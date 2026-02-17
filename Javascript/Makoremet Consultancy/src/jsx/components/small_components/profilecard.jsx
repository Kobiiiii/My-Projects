function Profilecard({src, title, position}) {
    return (
        <div className="profilecard">
            <div className="overlay"></div>
            <p className="name">{title}</p>
            <p className="position">{position}</p>
        
            <div className="profilepic">
                <img src={src}></img>
            </div>

            <button className="infobutton">Read More</button>
        
        </div>

    )
}

export default Profilecard