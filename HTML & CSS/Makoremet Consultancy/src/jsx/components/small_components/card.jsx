// Just for thge arrow.
import arrow from '/assets/images/arrow.svg'

function Card({src, title}) {
    return (
        <div className="card">

            <p className="title">{title}</p>

            <div className="icon">
                <img src={src}></img>
            </div>

            <div className="arrow">
                <img src={arrow}></img>
            </div>

        </div>
    )
}

export default Card