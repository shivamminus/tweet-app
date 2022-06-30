import React from "react";
import LiveSearchFilter from "./LiveSearchFilter";



function Navbar(props) {
    
    const onUserSearch = (searchloginid) => {

        props.searchloginid = searchloginid
        console.log("hamara bajaj",searchloginid)
        // loginInfo(event);
        // event.preventDefault();
    }
    

    let [theme, setTheme] = React.useState(localStorage.getItem("theme") || "light");

    React.useEffect(() => {
        if (theme === "dark") {
            document.body.classList.add("dark");
        } else {
            document.body.classList.remove("dark");
        }
    }, [theme])

    let x = localStorage.getItem("token");
    let a = { name: x ? "Settings" : "Login", link: x ? "/settings" : "/login" }
    let b = { name: x ? "Logout" : "Register", link: x ? "/logout" : "/register" }
    // let c = {name: x ? "search" : "", link: x ? "/search" : "/search"}
    // const {onSearch} = this.props;
    return (

        <div className="w3-bar w3-black">
            <a className="w3-bar-item w3-button" href="/">
                Tweet-App
            </a>
            <div style={{ float: "right" }}>
                <div className='w3-bar-item'>
                    <LiveSearchFilter

                        loginInfo={onUserSearch}
                    />
                </div>

                <button className="w3-bar-item w3-btn" onClick={() => {
                    if (theme === "dark") {
                        localStorage.setItem("theme", "light");
                        setTheme("light")
                    } else {
                        localStorage.setItem("theme", "dark");
                        setTheme("dark")
                    }
                }}> {theme === "dark" ? "☀️" : "🌙"}</button>
                
                <a className="w3-bar-item" >
                    @{localStorage.getItem("loginid")}
                </a>
                <a className="w3-bar-item w3-button" href={a.link}>
                    {a.name}
                </a>

                <a className="w3-bar-item w3-button" href={b.link}>
                    {b.name}
                </a>

            </div>
        </div>
    );
}

export default Navbar;
