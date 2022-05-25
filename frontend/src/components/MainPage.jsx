import React from "react";
import TweetItem from "./TweetItem";
import Axios from "axios";
import AddTweet from "./AddTweet";

class MainPage extends React.Component {
    state = {tweets: [], currentUser: {username: ""}}

    componentDidMount() {
        Axios.get("http://localhost:5000/tweets/all", 
        {headers: {
            'Authorization':`Bearer ${localStorage.getItem("token")}`,
            'Access-Control-Allow-Headers':window.location.origin
        }
    })
        .then(res => {
            this.setState({tweets: res.msg})
        });
        setTimeout(() => {
            Axios.get("/", {
                headers: {
                    Authorization: `Bearer ${localStorage.getItem("token")}`
                }
            }).then(res => {
                this.setState({currentUser: res.tweets})
            })
        }, 500)
    }

    render() {
        return (
            <React.Fragment>
                <div
                    className="w3-container w3-jumbo"
                    style={{margin: "3rem", paddingLeft: "1rem"}}>
                    <h1>Tweets</h1>
                    <button className="w3-button w3-blue w3-large" onClick={() => {
                        document.getElementById("addTweet").style.display = "block"
                    }}>Add tweet
                    </button>
                </div>
                <AddTweet/>
                <div className="w3-container">
                    {this.state.tweets.length === 0 ?
                        <p className="w3-xlarge w3-opacity" style={{marginLeft: "2rem"}}>No tweets! Create
                            one</p> : this.state.tweets.map((item, index) => {
                            return (
                                <TweetItem
                                    id={item.id}
                                    title={item.tweet}
                                    content={item.twwet}
                                    author={item.loginid}
                                    isOwner={this.state.currentUser.username === item.user.username}
                                    key={index}
                                />
                            );
                        })}
                </div>
            </React.Fragment>
        );
    }
}

export default MainPage;
