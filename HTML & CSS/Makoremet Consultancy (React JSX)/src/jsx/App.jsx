// Routing
import { BrowserRouter, Routes, Route, Link, Outlet } from 'react-router-dom';

// Styles
import '../styles/global/components.css'
import '../styles/global/global.css'

//Pages
import Home from '../jsx/pages/home.jsx'
import About from '../jsx/pages/about.jsx'

function App() {
  return (
      <BrowserRouter>
      <Routes>
        <Route path='/' element={<Home />}></Route>
        <Route path='/about' element={<About />}></Route>
      </Routes>
    </BrowserRouter>
)
}

export default App
