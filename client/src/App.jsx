import { useRef, useState } from "react";
import axios from 'axios';



export const App = () => {
    const [shortURL, setShortUrl] = useState(null);
    const longURLRef = useRef();
    const handleSubmit = e => {
        e.preventDefault();
        console.log({ longUrl: longURLRef.current.value })
        
        axios.post("http://localhost:8080/generate-short-url", {
            longURL: longURLRef.current.value,
        }).then(resp => {
            setShortUrl(resp.data.shortURL)
        }).catch(err => {
            alert(err)
        })
        
    }
    return (
        <div>
            <form onSubmit={handleSubmit}>
                <input type="textbox" name="longURL" id="longURL" ref={longURLRef}  />
                <input type="submit" name="submit" placeholder="submit" />
            </form>
            <a href={shortURL}>{shortURL} </a>
        </div>
    )
}