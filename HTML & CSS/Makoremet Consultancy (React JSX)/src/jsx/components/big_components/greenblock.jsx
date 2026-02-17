// Small Components
import Makoremet from '../small_components/makoremet.jsx'
import Image from '../small_components/image.jsx'

// Packages
import parse from "html-react-parser";


function Greenblock({img, heading, isMet, children}) {
    return (
        <div className='greenblock'>
            <div className='greenflex'>
                <div className="aboutblock">
                    <p className='heading'>{isMet ? <Makoremet color='var(--default-green)'></Makoremet> : <></>}{parse(heading)}</p>
                    <p>{children}</p>
                </div>

                <Image src={img} border="40px"></Image>
            </div>
        </div>
    )
}

export default Greenblock