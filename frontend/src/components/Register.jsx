import React, {Component} from "react";
import axios from "axios";
import Alert from "./Alert";
import {check} from "../login";

class Register extends Component {
    state = {err: ""};

    componentDidMount() {
        check().then(r => {if (r) {
            window.location = "/"
        }})
    }

    register = (e) => {
        e.preventDefault();
        axios
            .post("http://localhost:5000/tweets/register", {
                email: document.getElementById("email").value,
                loginid: document.getElementById("login-id").value,
                password: document.getElementById("password").value,
                first_name: document.getElementById("first-name").value,
                last_name: document.getElementById("last-name").value,
                contact: document.getElementById("contact").value,
            })
            .then((res) => {
                if (res.data.error) {
                    this.setState({err: res.data.error});
                } else {
                    window.location = "/login"
                }
            });
    };

    render() {
        return (
            <div className="w3-card-4" style={{margin: "2rem"}}>
                <div className="w3-container w3-blue w3-center w3-xlarge">
                    REGISTER
                </div>
                <div className="w3-container">
                    {this.state.err.length > 0 && (
                        <Alert
                            message={`Check your form and try again! (${this.state.err})`}
                        />
                    )}
                    <form onSubmit={this.register}>
                    <p>
                            <label htmlFor="first-name">First Name</label>
                            <input
                                type="text"
                                class="w3-input w3-border"
                                id="first-name"
                            />
                        </p>
                        <p>
                            <label htmlFor="last-name">Last Name</label>
                            <input
                                type="text"
                                class="w3-input w3-border"
                                id="last-name"
                            />
                        </p>
                        <p>
                            <label htmlFor="email">Email</label>
                            <input
                                type="email"
                                class="w3-input w3-border"
                                id="email"
                            />
                        </p>
                        <p>
                            <label htmlFor="login-id">Login ID</label>
                            <input
                                type="text"
                                class="w3-input w3-border"
                                id="login-id"
                            />
                        </p>
                        <p>
                            <label htmlFor="password">Password</label>
                            <input
                                type="password"
                                class="w3-input w3-border"
                                id="password"
                            />
                        </p>
                        <p>
                            <label htmlFor="contact">Contact</label>
                            <input
                                type="text"
                                class="w3-input w3-border"
                                id="contact"
                            />
                        </p>
                        
                        <p>
                            <button type="submit" class="w3-button w3-blue">
                                Register
                            </button>
                            {this.state.register && <p>You're registered!</p>}
                        </p>
                    </form>
                </div>
            </div>
        );
    }
}

export default Register;
