import React, { Component } from 'react'
import axios from 'axios'
import { base_url } from '../config'


class LiveSearchFilter extends Component {
    constructor(props) {
        super(props)
        this.state = {
            Profile: [],
        }
        this.getVal = this.getVal.bind(this)
        // this.node = React.createRef()
    }
    componentDidMount() {

        const concernedElement = document.getElementById("dropdownContext");
        const concernedInput = document.getElementById("searchBox");

        document.addEventListener("mousedown", (e) => {
        // console.log(concernedElement, e.target);
        if (concernedElement.contains(e.target) || concernedInput.contains(e.target)) {
            // console.log("clicked inside");
            if (this.state.Profile.length > 0) {
            concernedElement.classList.remove('display-none');
            concernedElement.classList.add('list-group');}
            
        } else {
            concernedElement.classList.add('display-none');

        }
        });

        // document.addEventListener('mousedown', this.getVal)
    }
    componentWillUnmount() {
        // document.removeEventListener('mousedown', this.getVal)
    }
    getVal = (e) => {
        // if (this.node.current.contains(e.target)) {
        //     return
        // }
        this.setState({
            userList: [],
        })
    }
    onChange = async (e) => {

        // console.clear();

        if (e.target.value === '') {
            this.setState({

                Profile: [],
            })
        }
        console.log(e.target.value)
        await axios.get(base_url + '/tweets/user/search/' + e.target.value, {
            headers: {
                'Authorization': `Bearer ${localStorage.getItem("token")}`,
                'Access-Control-Allow-Headers': window.location.origin,
                "Cache-Control": "no-store, no-cache"
            }
        }).then((res) => {
            console.log("RESULT for searching parameter : ", res)
            // console.log("RESULT for searching parameter : ", this.props.)
            this.setState({

                Profile: res.data.data,
            })
        })
            .catch((e) => {
                if (axios.isCancel(e) || e) {
                    console.log('Data not found.')
                }
            })
        // let stringKwd = e.target.value.toLowerCase()
        // let filterData = this.state.Profile.filter((item) => {
        //     return item.username.toLowerCase().indexOf(stringKwd) !== -1
        // })
        // this.setState({
        //     Profile: filterData,
        // })        
    }


    onSearch = (event) => {
        this.props.loginInfo(event);
        // event.preventDefault();
    }


    render() {
        const { loginInfo } = this.props
        return (

            <div>
                <div className="input-group mt-3">
                    <input
                        id="searchBox"
                        type="text"
                        className="form-control"
                        placeholder="Find User"
                        // ref={this.node}
                        onClick={this.getVal}
                        onChange={(e) => this.onChange(e)}
                    />
                </div>
                <div id="dropdownContext" className={this.state.Profile.length > 0 ? 'list-group' : 'display-none'}>
                    {this.state.Profile.map((item) => {
                        return (
                            <div>
                                <a onClick={() => this.onSearch(item.loginid)}
                                    className="list-group-item list-group-item-action"
                                >
                                    {item.loginid}
                                </a>
                            </div>
                        )
                    })}
                </div>
            </div>
        )
    }
}
export default LiveSearchFilter;