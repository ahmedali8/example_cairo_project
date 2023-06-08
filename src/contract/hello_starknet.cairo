#[contract]
mod HelloStarknet {
    struct Storage {
        balance: u128,
    }

    // Increases the balance by the given amount.
    #[external]
    fn increase_balance(amount: u128) {
        assert(amount != 0, 'Amount cannot be 0');
        assert(amount % 2 == 0, 'Amount cannot be odd');
        balance::write(balance::read() + amount);
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
