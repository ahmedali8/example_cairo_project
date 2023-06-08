1. Create unit test for HelloStarknet get_two method
2. Store balance in u128 rather than a felt data type. Modify corresponding methods and unit tests if necessary.
3. Already implemented increase_balance () is a bit boring so modify such that it only allows for to increase balance in even amounts. Of course start with a unit test.
4. We don't want the balance to go too high. Set up contract owner in a constructor and make sure that only owner can increase balance by more than 1000. Of course start with unit tests.
5. Owner would like to quickly check who has increased the balance. Lets store addresses of all users who have increased a balance in an array. Also make sure with unit tests that this information can be retreived.
6. Owner would like to quickly check by how much particual users have increased the balance.
   Lets store this data in a map. Also make sure with unit tests that this information can be retreived.
