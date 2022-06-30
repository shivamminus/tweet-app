import React from "react";
import { Editor } from "@tinymce/tinymce-react/lib/cjs/main/ts";
import axios from "axios";
import Alert from "./Alert";
import { base_url } from "../config";

class ReplyTweet extends React.Component {

    state = { content: "<p>I have to edit this!</p>", titleErr: "", contentErr: "", formErr: "" }

    handleEditorChange = (content, editor) => {
        this.setState({ content })
    }

    submitForm = (e) => {
        // e.preventDefault()
        if (this.state.content.length === 0) {
            this.setState(
                { contentErr: "Add some data to the content!" }
            )
            return;
        }


        var bodyFormData = new FormData()
        bodyFormData.append("retweet", this.state.content)
        bodyFormData.append("loginid", localStorage.getItem("loginid"))

        axios.post(base_url + "/retweet/" + this.props.replyItem, bodyFormData, {
            headers: {
                'Content-Type': 'Application/json',
                Authorization: "Bearer " + localStorage.getItem("token"),
                "Cache-Control": "no-store, no-cache"
            }
        }).then(res => {
            if (res.data.success) {

            } else {
                this.setState(
                    { formErr: res.data.error }
                )
            }
        })
    }

    render() {
        return (<div className="w3-modal w3-animate-opacity" id="replyTweet">
            <div className="w3-modal-content w3-card">
                <header className="w3-container w3-blue">
                    <span className="w3-button w3-display-topright w3-hover-none w3-hover-text-white" onClick={() => {
                        document.getElementById("replyTweet").style.display = "none"
                    }}>X</span>
                    <h2>Retweet</h2>
                </header>
                <form className="w3-container" onSubmit={this.submitForm}>
                    {this.state.formErr.length > 0 && <Alert message={this.state.formErr} />}
                    <div className="w3-section">

                        <p>
                            <Editor
                                initialValue="<p>Reply Tweet</p>"
                                init={{
                                    height: 300,
                                    menubar: false,
                                    statusbar: false,
                                    toolbar_mode: "sliding",
                                    plugins: [
                                        'advlist autolink lists link image imagetools media emoticons preview anchor',
                                        'searchreplace visualblocks code fullscreen',
                                        'insertdatetime media table paste code help wordcount'
                                    ],
                                    toolbar:
                                        'undo redo | formatselect | bold italic underline strikethrough | image anchor media | \
                                        alignleft aligncenter alignright alignjustify | \
                                        outdent indent | bulllist numlist | fullscreen preview | emoticons help',
                                    contextmenu: "bold italic underline indent outdent help"
                                }}
                                onEditorChange={this.handleEditorChange}
                            />
                            <small className="w3-text-gray">{this.state.contentErr}</small>
                        </p>

                        <p>
                            <button type="submit" className="w3-button w3-blue">Retweet</button>
                        </p>
                    </div>
                </form>
            </div>
        </div>)
    }
}

export default ReplyTweet;