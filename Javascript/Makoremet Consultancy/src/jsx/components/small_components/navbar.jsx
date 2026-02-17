import { Link } from 'react-router-dom';
import Home from '../../pages/home.jsx'
import About from '../../pages/about.jsx'

function Navbar() {
  return (
    <>
      <div id='navbar'>
        <div className='logo'></div>
          <div className='navbuttons'>
            <button><Link to="/about">About</Link></button>
            <button>Services</button>
          </div>
        <button className='contact'>Contact Us</button>
      </div>
    </>
  );
}

export default Navbar