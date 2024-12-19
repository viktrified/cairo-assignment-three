#[starknet::interface]
pub trait IHelloStarknet<TContractState> {
    fn add_points(ref self: TContractState, points: u128);
    fn Redeem_point(ref self: TContractState, amount: u128) -> u128;
    fn get_points(self: @TContractState) -> u128;
}

/// Simple contract for managing balance.
#[starknet::contract]
mod Points {
    use core::starknet::{ ContractAddress, get_caller_address};
    use core::starknet::storage::{Map, StoragePointerReadAccess, StoragePointerWriteAccess, StoragePathEntry};

    #[storage]
    struct Storage {
        balance: felt252,
        userPoints: Map<ContractAddress, u128>,
    }

    #[event]
    #[derive(Drop, starknet::Event)]
    pub enum Event{
        AddPoint: AddPoint,
        RedeemPoint: RedeemPoint,
    }

    #[derive(Drop, starknet::Event)]
    pub struct AddPoint {
        owner:ContractAddress,
        point: u128,
    }

        #[derive(Drop, starknet::Event)]
    pub struct RedeemPoint {
        owner:ContractAddress,
        point: u128,
    }

    #[abi(embed_v0)]
    impl HelloStarknetImpl of super::IHelloStarknet<ContractState> {

         fn add_points(ref self: ContractState,  points: u128)
         {
          let caller = get_caller_address();
         let previousPoint = self.userPoints.entry(caller).read();
         self.userPoints.entry(caller).write(previousPoint +points);

         self.emit(AddPoint{owner: caller,point: points});
         }

         fn Redeem_point(ref self: ContractState, amount: u128) -> u128 {
            assert(amount !=0, 'Amounty cannot be 0');
            let caller = get_caller_address();
            assert(self.userPoints.entry(caller).read() >= amount, 'Invalid amount');

            let points = self.userPoints.entry(caller).read() - amount;
            self.userPoints.entry(caller).write(points);
            self.emit(RedeemPoint{owner: caller, point: amount});
            return points;
         }

         fn get_points(self: @ContractState) -> u128{
         let caller = get_caller_address();
         return self.userPoints.entry(caller).read();
         }
    }
}