import React from "react";
import Axios from "axios";
import { base_url } from "../config";




function Retweet(props) {

    return (
        <div
            className="w3-card w3-border w3-border-gray w3-round-large"
            style={{ marginTop: "2rem" }}>
            <header className="w3-container w3-opacity w3-light-gray" style={{ padding: "1rem" }}>@{props.author}
                <span style={{ float: "right" }}>
                   
                    
                </span>
            </header>
            <div className="w3-container" style={{ padding: "2rem" }}>
                
                <div dangerouslySetInnerHTML={{ __html: props.content }} />
                {/* <TweetItem /> */}
            </div>
            <footer className="w3-container w3-center w3-large">


            
            </footer>
        </div>
    );
}

export default Retweet;
