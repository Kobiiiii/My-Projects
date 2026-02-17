import {people} from '../../data/carddata'
import ProfileCard from '../small_components/profilecard.jsx'

function List() {
    const listItems = people.map(people =>
        <ProfileCard
        key={people.id}
        src={people.img}
        title={people.name}
        position={people.position}>
        </ProfileCard>
    )
    
    return listItems
}

export default List
