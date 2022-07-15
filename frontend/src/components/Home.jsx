import React from "react";

function Home() {
    return (
        <React.Fragment>
            <div
                className="w3-container w3-center w3-blue"
                style={{ padding: "2rem" }}>
                <h1 className="w3-jumbo">Tweet App</h1>
                <button
                    className="w3-button w3-pink"
                    style={{ marginRight: "1rem" }}
                    onClick={() => (window.location = "/login")}>
                    Login
                </button>
                <button
                    className="w3-button w3-pink"
                    onClick={() => (window.location = "/register")}>
                    Register
                </button>
            </div>

            <div 
                className="w3-container w3-center w3-blue"
                style={{ padding: "2rem", marginTop: "2rem" }}>
                <h2>Hey!! Welcome to Twitter</h2>
                <p>
                To get started, first enter your loginid and password to get started
             </p>
            </div>

            <div
                className="w3-container w3-center w3-blue"
                style={{ padding: "2rem", marginTop: "2rem" }}>
                <h2>About Twitter</h2>
                <p className="w3-center">
                Twitter is a free social networking site where users broadcast short posts known as tweets. These tweets can contain text, videos, photos or links. To access Twitter, users need an internet connection or smart phone to use the app or website, Twitter.com.
                </p>
            </div>

        </React.Fragment>
    );
}

export default Home;
