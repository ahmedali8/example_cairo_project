#[contract]
mod HelloStarknet {
    use starknet::get_caller_address;
    use starknet::ContractAddress;
    use starknet::ContractAddressIntoFelt252;
    use traits::Into;

    struct Storage {
        balance: u128,
        owner: felt252,
    }

    #[constructor]
    fn constructor(_owner: felt252){
        owner::write(_owner);
    }

    // Increases the balance by the given amount.
    #[external]
    fn increase_balance(amount: u128) {
        assert(get_caller_address().into() == owner::read(), 'Not authorized');
        assert(amount <= 1000, 'Amount not valid');
        assert(amount % 2 == 0, 'Amount cannot be odd');
        balance::write(balance::read() + amount);
    }

    // Returns the owner.
    #[view]
    fn get_owner() -> felt252 {
        owner::read()
    }

    // Returns the current balance.
    #[view]
    fn get_balance() -> u128 {
        balance::read()
    }

    // Calls a function defined in outside module
    #[view]
    fn get_two() -> felt252 {
        hello_starknet::business_logic::utils::returns_two()
    }
}
