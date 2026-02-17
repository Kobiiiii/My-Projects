

// Props allows for react components to have properties making them customisable.
// We made a prop so that the user can add different type of styles for every instance of a component.
function Makoremet({size, color}) {
    return (
        <span style={{ fontSize: size, color: color}}>Makoremet Consultancy</span>
    )
}

export default Makoremet