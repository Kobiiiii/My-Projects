function Image({src, border}) {
    return (
    <div className="container" style={{borderRadius: border}}>
        <img src={src} style={{borderRadius: border}}></img>
    </div>
    )
}

export default Image