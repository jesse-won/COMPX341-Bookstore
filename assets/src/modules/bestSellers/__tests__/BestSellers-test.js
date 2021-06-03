import React from 'react';
import Adapter from 'enzyme-adapter-react-16';
import {shallow, configure} from 'enzyme';
import BestSellers from '../BestSellers'

// configure enzyme adapter
configure({ adapter: new Adapter() })

// Declare test constants
const expectedString = 'Top 20 best sellers';
// Run test
test('BestSellers renders \''+ expectedString +'\'', () => {
    const bestSellers = shallow(<BestSellers />)
    expect(bestSellers.find('h3').text()).toEqual(expectedString);
});
