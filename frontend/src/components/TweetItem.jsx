import React from "react";
import Axios from "axios";
import { base_url } from "../config";

function deleteTweet(tid) {
    Axios.delete(base_url+"/api/deletetweet/" + tid, { headers: { Authorization: "Bearer " + localStorage.getItem("token") } }).then(res => {
        console.log(res.data)
        window.location.reload();
    })
}
function likeTweet(tid, author) {
    Axios.get(base_url+"/tweets/"+author+"/like", {
        headers:
            { Authorization: "Bearer " + localStorage.getItem("token"), 'Content-Type': 'multipart/form-data' },
        data: { tweet_id: tid, 'already-liked':false, 'user_id': localStorage.getItem("user_id")
    }})
         .then(res => {
        console.log(res.data)
        window.location.reload();
    })
}

function retweet(tid) {
    Axios.get(base_url+"/tweets/cicada/like" + tid, {
        headers:
            { Authorization: "Bearer " + localStorage.getItem("token"), 'Content-Type': 'multipart/form-data' },
        data: { tweet_id: tid, 'already-liked':true, 
    }})
         .then(res => {
        console.log(res.data)
        window.location.reload();
    })
}


function TweetItem(props) {

    return (
        <div
            className="w3-card w3-border w3-border-gray w3-round-large"
            style={{ marginTop: "2rem" }}>
            <header className="w3-container w3-opacity w3-light-gray" style={{ padding: "1rem" }}>@{props.author}
                <span style={{ float: "right" }}>
                    <button className="w3-button" style={{ marginRight: "2rem" }} onClick={() => likeTweet(props.id, props.author)}>
                        Like
                    </button>
                    <button className="w3-button" style={{ marginRight: "2rem" }} onClick={() => retweet(props.id)}>
                        Retweet
                    </button>
                </span>
            </header>
            <div className="w3-container" style={{ padding: "2rem" }}>
                <h2 className="w3-xxlarge">
                    <span className="w3-opacity">{props.title}</span>
                    {props.isOwner &&
                        <button className="w3-right w3-button w3-red w3-large w3-hover-pale-red w3-round-large" onClick={() => deleteTweet(props.id)}>Delete
                        </button>}
                </h2>
                <div dangerouslySetInnerHTML={{ __html: props.content }} />
            </div>
            <footer className="w3-container w3-center w3-large">

                <button className="w3-button">Reply</button>
            </footer>
        </div>
    );
}

export default TweetItem;
