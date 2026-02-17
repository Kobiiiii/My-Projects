// Small Components
import Header from "../small_components/header.jsx"

function Contactus() {
    return (
        <>
            <Header message="Contact Us"></Header>
            <p className="description">Have a general enquiry? Contact us using the form below</p>

            <div className='contactus'>
                <form>
                    <input type='text' placeholder='Full Name'></input>
                    <input type='text' placeholder='Email'></input>
                    <textarea placeholder='Message'></textarea>
                </form>

                <iframe 
                src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d970675.997096741!2d28.994979858398423!3d-18.13149626096973!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x1936b524bb647597%3A0x29c843f3b4cb0fba!2sChegutu%2C%20Zimbabwe!5e0!3m2!1sen!2suk!4v1770134369507!5m2!1sen!2suk" 
                allowFullScreen="" 
                loading="lazy" 
                referrerpolicy="no-referrer-when-downgrade">
                </iframe>
            </div>
        </>
    )
}

export default Contactus