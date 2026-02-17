// React Stuff
import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'

// Styles
import '../styles/index.css'

// Apps
import App from './App.jsx'

// Just remember that this file exsists to all your stuff can render on one component.
createRoot(document.getElementById('root')).render(
  <StrictMode>
    <App />
  </StrictMode>,
)
