import React from "react";
import { Editor } from "@tinymce/tinymce-react/lib/cjs/main/ts";
import axios from "axios";
import Alert from "./Alert";
import { base_url } from "../config";




const state = { content: "<p>I have to edit this!</p>", titleErr: "", contentErr: "", formErr: "" }

function handleEditorChange (content, editor)  {
    state.content = content
    // this.setState({ content })
}

function submitForm (e) {
    // e.preventDefault()
    if (state.content.length === 0) {
        state.contentErr = "Add some data to the content!"
        // this.setState(
        //     { contentErr: "Add some data to the content!" }
        // )
        return;
    }


    var bodyFormData = new FormData()
    bodyFormData.append("retweet", state.content)
    bodyFormData.append("loginid", localStorage.getItem("loginid"))
 

    axios.post(base_url + "/retweet/" + e, bodyFormData, {
        headers: {
            'Content-Type': 'Application/json',
            Authorization: "Bearer " + localStorage.getItem("token"),
            "Cache-Control": "no-store, no-cache"
        }
    }).then(res => {
        if (res.data.success) {

        } else {
            // this.setState(
            //     { formErr: res.data.error }
            // )

        }
    })
}

function ReplyTweet(props) {



    return (<div className="replyTweet-Modal w3-animate-opacity" id={"replyTweet"+props.replyItem}>
        <div className="replyTweet-Modal-content replyTweet-Modal-card">
            <header className="replyTweet-Modal-container replyTweet-Modal-blue">
                <span className="w3-button w3-display-topright w3-hover-none w3-hover-text-white" onClick={() => {
                    document.getElementById("replyTweet" + props.replyItem).style.display = "none"
                }}>X</span>
                <h2>Retweet</h2>
            </header>
            <form className="replyTweet-Modal-container" onSubmit={()=>submitForm(props.replyItem)}>
                {state.formErr.length > 0 && <Alert message={state.formErr} />}
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
                            onEditorChange={handleEditorChange}
                        />
                        <small className="w3-text-gray">{state.contentErr}</small>
                    </p>

                    <p>
                        <button type="submit" className="w3-button w3-blue">Retweet</button>
                    </p>
                </div>
            </form>
        </div>
    </div>)

}

export default ReplyTweet;