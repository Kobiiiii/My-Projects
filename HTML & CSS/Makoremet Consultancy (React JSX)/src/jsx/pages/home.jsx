// Styles
import '../../styles/global/components.css'
import '../../styles/global/global.css'
import '../../styles/pages/home.css'

// Small Components
import Navbar from '../components/small_components/navbar.jsx'
import Makoremet from '../components/small_components/makoremet.jsx'
import Image from "../components/small_components/image.jsx"
import Header from "../components/small_components/header.jsx"
import Card from "../components/small_components/card.jsx"
import Profilecard from "../components/small_components/profilecard.jsx"

// Big Components
import Services from '../components/big_components/services.jsx'
import Greenblock from '../components/big_components/greenblock.jsx'
import Contactus from '../components/big_components/contactus.jsx'
import List from '../components/big_components/list.jsx'
import Hero from '../components/big_components/hero.jsx'
import Team from '../components/big_components/team.jsx'

// Images
// remember a / at the beginning of a path
import dig from '/assets/images/dig.png'
import profile from '/assets/images/profile.jpg'

function Home() {

    return (
    <>
        <Navbar></Navbar>
        <Hero></Hero>

        {/* There has to be a space for the heading string or will not look right*/}
        <Greenblock 
        img={dig}
        heading={" is the thing for you"}
        isMet={true}>
        Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.</Greenblock>

        <Services></Services>
        <Team></Team>

        <Contactus></Contactus>
    </>
)
}

export default Home