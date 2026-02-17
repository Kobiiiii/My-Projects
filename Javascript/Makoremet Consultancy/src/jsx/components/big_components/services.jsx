// Small Components
import Header from '../small_components/header.jsx'
import Card from '../small_components/card.jsx'

// Just rember that all image icons should be in here unless you make a prop.
// Icons
import shovel from '/assets/images/shovel.svg'

function Services() {
    return (
        <>
        <Header message="Our Services"></Header>
        <p className="description">The company has metallurgical engineers that help you in mineral processing for gold and chrome, the company helps you in the following:</p>

        <div className='grid'>
            <Card src={shovel} title="Crushing and Milling"></Card>
            <Card src={shovel} title="VAT Leaching"></Card>
            <Card src={shovel} title="CIP/CIL Plants"></Card>
            <Card src={shovel} title="Gold Processing Checmical Supply"></Card>
            <Card src={shovel} title="Elution Services"></Card>
            <Card src={shovel} title="Crushing and Milling"></Card>
        </div>
        </>
    )
}

export default Services