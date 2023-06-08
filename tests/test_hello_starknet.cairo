use array::ArrayTrait;
use result::ResultTrait;
use starknet::ContractAddress;
use starknet::ContractAddressIntoFelt252;
use starknet::Felt252TryIntoContractAddress;
use traits::Into;

const PRANK_CALLER: felt252 = 123;

#[test]
fn test_increase_balance() {
    let mut calldata = ArrayTrait::new();
    calldata.append(PRANK_CALLER);
    let contract_address = deploy_contract('hello_starknet', @calldata).unwrap();

    let result_before = call(contract_address, 'get_balance', @ArrayTrait::new()).unwrap();
    assert(*result_before.at(0_u32) == 0, 'Invalid balance');

    // Pranked the address
    start_prank(PRANK_CALLER, contract_address).unwrap();

    let mut invoke_calldata = ArrayTrait::new();
    invoke_calldata.append(42);
    invoke(contract_address, 'increase_balance', @invoke_calldata).unwrap();

    let result_after = call(contract_address, 'get_balance', @ArrayTrait::new()).unwrap();
    assert(*result_after.at(0_u32) == 42, 'Invalid balance');
}

#[test]
fn test_cannot_increase_balance_by_non_owner() {
    let mut calldata = ArrayTrait::new();
    calldata.append(PRANK_CALLER);
    let contract_address = deploy_contract('hello_starknet', @calldata).unwrap();

    let result_before = call(contract_address, 'get_balance', @ArrayTrait::new()).unwrap();
    assert(*result_before.at(0_u32) == 0, 'Invalid balance');

    let mut invoke_calldata = ArrayTrait::new();
    invoke_calldata.append(0);
    let invoke_result = invoke(contract_address, 'increase_balance', @invoke_calldata);

    assert(invoke_result.is_err(), 'Invoke should fail');
}

#[test]
fn test_cannot_increase_balance_with_value_greater_than_thousand() {
    let mut calldata = ArrayTrait::new();
    calldata.append(PRANK_CALLER);
    let contract_address = deploy_contract('hello_starknet', @calldata).unwrap();

    let result_before = call(contract_address, 'get_balance', @ArrayTrait::new()).unwrap();
    assert(*result_before.at(0_u32) == 0, 'Invalid balance');

    // Pranked the address
    start_prank(PRANK_CALLER, contract_address).unwrap();

    let mut invoke_calldata = ArrayTrait::new();
    invoke_calldata.append(1001);
    let invoke_result = invoke(contract_address, 'increase_balance', @invoke_calldata);

    assert(invoke_result.is_err(), 'Invoke should fail');
}

#[test]
fn test_cannot_increase_balance_with_zero_value() {
    let mut calldata = ArrayTrait::new();
    calldata.append(PRANK_CALLER);
    let contract_address = deploy_contract('hello_starknet', @calldata).unwrap();

    let result_before = call(contract_address, 'get_balance', @ArrayTrait::new()).unwrap();
    assert(*result_before.at(0_u32) == 0, 'Invalid balance');

    // Pranked the address
    start_prank(PRANK_CALLER, contract_address).unwrap();

    let mut invoke_calldata = ArrayTrait::new();
    invoke_calldata.append(0);
    let invoke_result = invoke(contract_address, 'increase_balance', @invoke_calldata);

    assert(invoke_result.is_err(), 'Invoke should fail');
}

#[test]
fn test_cannot_increase_balance_with_odd_value() {
    let mut calldata = ArrayTrait::new();
    calldata.append(PRANK_CALLER);
    let contract_address = deploy_contract('hello_starknet', @calldata).unwrap();

    let result_before = call(contract_address, 'get_balance', @ArrayTrait::new()).unwrap();
    assert(*result_before.at(0_u32) == 0, 'Invalid balance');

    // Pranked the address
    start_prank(PRANK_CALLER, contract_address).unwrap();

    let mut invoke_calldata = ArrayTrait::new();
    invoke_calldata.append(99);
    let invoke_result = invoke(contract_address, 'increase_balance', @invoke_calldata);

    assert(invoke_result.is_err(), 'Invoke should fail');
}

#[test]
fn test_get_two() {
    let contract_address = deploy_contract('hello_starknet', @ArrayTrait::new()).unwrap();
    let result = call(contract_address, 'get_two', @ArrayTrait::new()).unwrap();
    assert(*result.at(0_u32) == 2, 'Invalid result');
}