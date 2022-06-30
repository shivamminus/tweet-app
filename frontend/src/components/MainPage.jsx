import React from "react";
import TweetItem from "./TweetItem";
import Axios from "axios";
import AddTweet from "./AddTweet";
import { base_url } from "../config";
// import LiveSearchFilter from "./LiveSearchFilter";
import Navbar from "./Navbar";

class MainPage extends React.Component {
    constructor(props){
        super(props)
        this.state = {tweets: [], currentUser: {username: ""}}
        
    }


    componentDidMount() {
        Axios.get(base_url+"/tweets/all", 
        {headers: {
            'Authorization':`Bearer ${localStorage.getItem("token")}`,
            'Access-Control-Allow-Headers':window.location.origin,
            "Cache-Control": "no-store, no-cache"
        }
    })
        .then(res => {
            // console.log("RESULT:",res.data.tweets)
            this.setState({tweets: res.data.tweets})   
            // console.log("RESULT1:",this.state.tweets) 
            this.setState({currentUser:  {username: localStorage.getItem("loginid")}})
        });
        setInterval(() => {
            Axios.get(base_url+"/tweets/all", {
                headers: {
                    Authorization: `Bearer ${localStorage.getItem("token")}`,
                    'Access-Control-Allow-Headers':window.location.origin,
                    "Cache-Control": "no-store, no-cache"
                }
            }).then(res => {
                this.setState({currentUser:  {username: localStorage.getItem("loginid")}})
                this.setState({tweets: res.data.tweets})
            })
        },5000 )
    }

    render() {
        // const searchloginid = this.props.searchloginid;


        // console.log("data in events map",searchloginid)
        return (
            <React.Fragment>
                <div className='w3-bar-item'>
                    <Navbar 
                    // searchloginid = {searchloginid}
                    />
                </div>
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
                                    title={item.title}
                                    content={item.tweet}
                                    author={item.loginid}
                                    isOwner={this.state.currentUser.username === item.loginid}
                                    already_liked = {item.already_liked}
                                    key={index}
                                    retweet = {item.retweet}
                                />
                            );
                        })}
                </div>
            </React.Fragment>
        );
    }
}

export default MainPage;
