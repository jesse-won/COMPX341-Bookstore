import React from 'react';
import Adapter from 'enzyme-adapter-react-16';
import {shallow, configure} from 'enzyme';
import PastPurchases from '../PastPurchases'

// configure enzyme adapter
configure({ adapter: new Adapter() });

// Declare test constants
const testEmail = 'test@gmail.com';
const expectedString = 'Past purchases';

// Run test
test('PastPurchases renders \''+ testEmail +'\'', () => {
    const pastPurchases = shallow(<PastPurchases />) // Create shallow of past purchases component
    let userInfoData = {attributes: {email: testEmail}};

    // Test that Hello <email> header renders correctly using state data
    pastPurchases.setState({userInfo: userInfoData}); // Set test state of component to test with
    expect(pastPurchases.find('h3').at(0).text()).toEqual('Hello ' + testEmail + '!');

    // Test that Header renders correctly 
    expect(pastPurchases.find('h3').at(1).text()).toEqual(expectedString);
});
