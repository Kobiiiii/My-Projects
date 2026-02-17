// Small Components
import List from '../big_components/list.jsx'

function Team() {
    return (
        <>
        <div className='greenblock'>
            <h1 style={{color: "var(--calm)"}}>Meet The Team</h1>
 

            <div className="scrollbuttons">
                <button> {"<"} </button>
                <button> {">"} </button>
            </div>

            <div className='slidercontainer'>
                <div className='cardslider'>
                    <List></List>
                </div>
            </div>
        </div>
        </>
    )
}

export default Team