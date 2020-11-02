import 'starcoin/starcoin.dart';
import 'serde/serde.dart';
import 'dart:typed_data';


class TransactionBuilder {


	static Script encode_accept_token_script(TypeTag token_type) {

    var code = new Bytes(Uint8List.fromList([-95, 28, -21, 11, 1, 0, 0, 0, 6, 1, 0, 2, 3, 2, 6, 4, 8, 2, 5, 10, 7, 7, 17, 21, 8, 38, 16, 0, 0, 0, 1, 0, 1, 1, 1, 0, 2, 1, 6, 12, 0, 1, 9, 0, 7, 65, 99, 99, 111, 117, 110, 116, 12, 97, 99, 99, 101, 112, 116, 95, 116, 111, 107, 101, 110, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 1, 3, 11, 0, 56, 0, 2]));
		List<TypeTag> ty_args = new List<TypeTag>(1);
		ty_args[0] = token_type;
		var args = List<TransactionArgument>();

    var script = new Script(code,ty_args,args);
    return script;
  }

	static Script encode_cast_vote_script(TypeTag token, TypeTag action_t, AccountAddress proposer_address, int proposal_id, bool agree, Int128 votes) {

    var code = new Bytes(Uint8List.fromList([-95, 28, -21, 11, 1, 0, 0, 0, 7, 1, 0, 6, 2, 6, 5, 3, 11, 13, 4, 24, 4, 5, 28, 37, 7, 65, 37, 8, 102, 16, 0, 0, 0, 1, 0, 2, 2, 2, 1, 1, 1, 0, 3, 0, 1, 1, 1, 1, 4, 2, 3, 2, 2, 1, 0, 5, 1, 6, 2, 6, 12, 4, 1, 11, 0, 1, 9, 0, 5, 6, 12, 5, 3, 11, 0, 1, 9, 0, 1, 0, 5, 6, 12, 5, 3, 1, 4, 1, 9, 0, 2, 9, 0, 9, 1, 7, 65, 99, 99, 111, 117, 110, 116, 3, 68, 97, 111, 5, 84, 111, 107, 101, 110, 8, 119, 105, 116, 104, 100, 114, 97, 119, 9, 99, 97, 115, 116, 95, 118, 111, 116, 101, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 2, 1, 4, 1, 11, 10, 0, 10, 4, 56, 0, 12, 5, 11, 0, 10, 1, 10, 2, 11, 5, 10, 3, 56, 1, 2]));
		List<TypeTag> ty_args = new List<TypeTag>(2);
		ty_args[0] = token;
		ty_args[1] = action_t;
		List<TransactionArgument> args = new List<TransactionArgument>(4);
		args[0] = new TransactionArgumentAddressItem(proposer_address);
		args[1] = new TransactionArgumentU64Item(proposal_id);
		args[2] = new TransactionArgumentBoolItem(agree);
		args[3] = new TransactionArgumentU128Item(votes);

    var script = new Script(code,ty_args,args);
    return script;
  }

	static Script encode_create_account_script(TypeTag token_type, AccountAddress fresh_address, Bytes auth_key, Int128 initial_amount) {

    var code = new Bytes(Uint8List.fromList([-95, 28, -21, 11, 1, 0, 0, 0, 7, 1, 0, 4, 3, 4, 17, 4, 21, 4, 5, 25, 27, 7, 52, 56, 8, 108, 16, 6, 124, 10, 0, 0, 0, 1, 1, 2, 0, 0, 0, 0, 3, 1, 2, 1, 1, 0, 4, 3, 4, 1, 1, 1, 7, 2, 7, 1, 3, 1, 10, 2, 1, 5, 3, 6, 12, 5, 4, 0, 4, 6, 12, 5, 10, 2, 4, 3, 5, 1, 3, 1, 9, 0, 7, 65, 99, 99, 111, 117, 110, 116, 6, 69, 114, 114, 111, 114, 115, 16, 105, 110, 118, 97, 108, 105, 100, 95, 97, 114, 103, 117, 109, 101, 110, 116, 14, 99, 114, 101, 97, 116, 101, 95, 97, 99, 99, 111, 117, 110, 116, 8, 112, 97, 121, 95, 102, 114, 111, 109, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 3, 8, 101, 0, 0, 0, 0, 0, 0, 0, 1, 1, 5, 6, 29, 11, 2, 56, 0, 12, 4, 10, 1, 10, 4, 33, 7, 0, 17, 0, 12, 6, 12, 5, 11, 5, 3, 16, 11, 0, 1, 11, 6, 39, 10, 3, 50, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 36, 3, 21, 5, 26, 11, 0, 10, 1, 10, 3, 56, 1, 5, 28, 11, 0, 1, 2]));
		List<TypeTag> ty_args = new List<TypeTag>(1);
		ty_args[0] = token_type;
		List<TransactionArgument> args = new List<TransactionArgument>(3);
		args[0] = new TransactionArgumentAddressItem(fresh_address);
		args[1] = new TransactionArgumentU8VectorItem(auth_key);
		args[2] = new TransactionArgumentU128Item(initial_amount);

    var script = new Script(code,ty_args,args);
    return script;
  }

	static Script encode_destroy_terminated_proposal_script(TypeTag token, TypeTag action, AccountAddress proposer_address, int proposal_id) {

    var code = new Bytes(Uint8List.fromList([-95, 28, -21, 11, 1, 0, 0, 0, 6, 1, 0, 2, 3, 2, 7, 4, 9, 2, 5, 11, 14, 7, 25, 32, 8, 57, 16, 0, 0, 0, 1, 0, 1, 2, 2, 1, 0, 3, 2, 5, 3, 0, 3, 6, 12, 5, 3, 2, 9, 0, 9, 1, 3, 68, 97, 111, 27, 100, 101, 115, 116, 114, 111, 121, 95, 116, 101, 114, 109, 105, 110, 97, 116, 101, 100, 95, 112, 114, 111, 112, 111, 115, 97, 108, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 2, 1, 2, 1, 4, 10, 1, 10, 2, 56, 0, 2]));
		List<TypeTag> ty_args = new List<TypeTag>(2);
		ty_args[0] = token;
		ty_args[1] = action;
		List<TransactionArgument> args = new List<TransactionArgument>(2);
		args[0] = new TransactionArgumentAddressItem(proposer_address);
		args[1] = new TransactionArgumentU64Item(proposal_id);

    var script = new Script(code,ty_args,args);
    return script;
  }

	static Script encode_empty_script_script() {

    var code = new Bytes(Uint8List.fromList([-95, 28, -21, 11, 1, 0, 0, 0, 1, 5, 0, 1, 0, 0, 0, 0, 1, 2]));
		var ty_args = List<TypeTag>();
		var args = List<TransactionArgument>();

    var script = new Script(code,ty_args,args);
    return script;
  }

	static Script encode_execute_modify_dao_config_proposal_script(TypeTag token, AccountAddress proposer_address, int proposal_id) {

    var code = new Bytes(Uint8List.fromList([-95, 28, -21, 11, 1, 0, 0, 0, 6, 1, 0, 2, 3, 2, 6, 4, 8, 2, 5, 10, 12, 7, 22, 32, 8, 54, 16, 0, 0, 0, 1, 0, 1, 1, 2, 0, 3, 2, 5, 3, 0, 3, 6, 12, 5, 3, 1, 9, 0, 23, 77, 111, 100, 105, 102, 121, 68, 97, 111, 67, 111, 110, 102, 105, 103, 80, 114, 111, 112, 111, 115, 97, 108, 7, 101, 120, 101, 99, 117, 116, 101, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 1, 4, 10, 1, 10, 2, 56, 0, 2]));
		List<TypeTag> ty_args = new List<TypeTag>(1);
		ty_args[0] = token;
		List<TransactionArgument> args = new List<TransactionArgument>(2);
		args[0] = new TransactionArgumentAddressItem(proposer_address);
		args[1] = new TransactionArgumentU64Item(proposal_id);

    var script = new Script(code,ty_args,args);
    return script;
  }

	static Script encode_execute_on_chain_config_proposal_script(TypeTag config_t, int proposal_id) {

    var code = new Bytes(Uint8List.fromList([-95, 28, -21, 11, 1, 0, 0, 0, 7, 1, 0, 6, 2, 6, 4, 3, 10, 12, 4, 22, 2, 5, 24, 18, 7, 42, 47, 8, 89, 16, 0, 0, 0, 1, 0, 2, 1, 1, 2, 0, 0, 3, 0, 1, 2, 2, 2, 2, 4, 2, 3, 0, 0, 5, 2, 5, 3, 0, 1, 6, 12, 1, 5, 2, 6, 12, 3, 2, 8, 0, 9, 0, 16, 79, 110, 67, 104, 97, 105, 110, 67, 111, 110, 102, 105, 103, 68, 97, 111, 3, 83, 84, 67, 6, 83, 105, 103, 110, 101, 114, 7, 101, 120, 101, 99, 117, 116, 101, 10, 97, 100, 100, 114, 101, 115, 115, 95, 111, 102, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 4, 1, 5, 11, 0, 17, 1, 10, 1, 56, 0, 2]));
		List<TypeTag> ty_args = new List<TypeTag>(1);
		ty_args[0] = config_t;
		List<TransactionArgument> args = new List<TransactionArgument>(1);
		args[0] = new TransactionArgumentU64Item(proposal_id);

    var script = new Script(code,ty_args,args);
    return script;
  }

	static Script encode_peer_to_peer_script(TypeTag token_type, AccountAddress payee, Bytes payee_auth_key, Int128 amount) {

    var code = new Bytes(Uint8List.fromList([-95, 28, -21, 11, 1, 0, 0, 0, 7, 1, 0, 4, 3, 4, 22, 4, 26, 4, 5, 30, 29, 7, 59, 66, 8, 125, 16, 6, -115, 1, 10, 0, 0, 0, 1, 1, 2, 0, 0, 0, 0, 3, 1, 2, 1, 1, 0, 4, 2, 3, 0, 0, 5, 4, 5, 1, 1, 1, 8, 3, 8, 1, 3, 1, 10, 2, 1, 5, 1, 1, 3, 6, 12, 5, 4, 0, 4, 6, 12, 5, 10, 2, 4, 3, 5, 1, 3, 1, 9, 0, 7, 65, 99, 99, 111, 117, 110, 116, 6, 69, 114, 114, 111, 114, 115, 16, 105, 110, 118, 97, 108, 105, 100, 95, 97, 114, 103, 117, 109, 101, 110, 116, 14, 99, 114, 101, 97, 116, 101, 95, 97, 99, 99, 111, 117, 110, 116, 9, 101, 120, 105, 115, 116, 115, 95, 97, 116, 8, 112, 97, 121, 95, 102, 114, 111, 109, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 3, 8, 101, 0, 0, 0, 0, 0, 0, 0, 1, 1, 6, 7, 26, 10, 1, 17, 2, 32, 3, 5, 5, 21, 11, 2, 56, 0, 12, 4, 10, 1, 10, 4, 33, 7, 0, 17, 0, 12, 6, 12, 5, 11, 5, 3, 21, 11, 0, 1, 11, 6, 39, 11, 0, 10, 1, 10, 3, 56, 1, 2]));
		List<TypeTag> ty_args = new List<TypeTag>(1);
		ty_args[0] = token_type;
		List<TransactionArgument> args = new List<TransactionArgument>(3);
		args[0] = new TransactionArgumentAddressItem(payee);
		args[1] = new TransactionArgumentU8VectorItem(payee_auth_key);
		args[2] = new TransactionArgumentU128Item(amount);

    var script = new Script(code,ty_args,args);
    return script;
  }

	static Script encode_peer_to_peer_with_metadata_script(TypeTag token_type, AccountAddress payee, Bytes payee_auth_key, Int128 amount, Bytes metadata) {

    var code = new Bytes(Uint8List.fromList([-95, 28, -21, 11, 1, 0, 0, 0, 7, 1, 0, 4, 3, 4, 22, 4, 26, 4, 5, 30, 33, 7, 63, 80, 8, -113, 1, 16, 6, -97, 1, 10, 0, 0, 0, 1, 1, 2, 0, 0, 0, 0, 3, 1, 2, 1, 1, 0, 4, 2, 3, 0, 0, 5, 4, 5, 1, 1, 1, 8, 3, 8, 1, 3, 1, 10, 2, 1, 5, 1, 1, 4, 6, 12, 5, 4, 10, 2, 0, 5, 6, 12, 5, 10, 2, 4, 10, 2, 3, 5, 1, 3, 1, 9, 0, 7, 65, 99, 99, 111, 117, 110, 116, 6, 69, 114, 114, 111, 114, 115, 16, 105, 110, 118, 97, 108, 105, 100, 95, 97, 114, 103, 117, 109, 101, 110, 116, 14, 99, 114, 101, 97, 116, 101, 95, 97, 99, 99, 111, 117, 110, 116, 9, 101, 120, 105, 115, 116, 115, 95, 97, 116, 22, 112, 97, 121, 95, 102, 114, 111, 109, 95, 119, 105, 116, 104, 95, 109, 101, 116, 97, 100, 97, 116, 97, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 3, 8, 101, 0, 0, 0, 0, 0, 0, 0, 1, 1, 6, 7, 27, 10, 1, 17, 2, 32, 3, 5, 5, 21, 11, 2, 56, 0, 12, 5, 10, 1, 10, 5, 33, 7, 0, 17, 0, 12, 7, 12, 6, 11, 6, 3, 21, 11, 0, 1, 11, 7, 39, 11, 0, 10, 1, 10, 3, 11, 4, 56, 1, 2]));
		List<TypeTag> ty_args = new List<TypeTag>(1);
		ty_args[0] = token_type;
		List<TransactionArgument> args = new List<TransactionArgument>(4);
		args[0] = new TransactionArgumentAddressItem(payee);
		args[1] = new TransactionArgumentU8VectorItem(payee_auth_key);
		args[2] = new TransactionArgumentU128Item(amount);
		args[3] = new TransactionArgumentU8VectorItem(metadata);

    var script = new Script(code,ty_args,args);
    return script;
  }

	static Script encode_propose_modify_dao_config_script(TypeTag token, int voting_delay, int voting_period, int voting_quorum_rate, int min_action_delay, int exec_delay) {

    var code = new Bytes(Uint8List.fromList([-95, 28, -21, 11, 1, 0, 0, 0, 6, 1, 0, 2, 3, 2, 6, 4, 8, 2, 5, 10, 12, 7, 22, 32, 8, 54, 16, 0, 0, 0, 1, 0, 1, 1, 2, 0, 2, 6, 6, 12, 3, 3, 2, 3, 3, 0, 1, 9, 0, 23, 77, 111, 100, 105, 102, 121, 68, 97, 111, 67, 111, 110, 102, 105, 103, 80, 114, 111, 112, 111, 115, 97, 108, 7, 112, 114, 111, 112, 111, 115, 101, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 0, 1, 8, 11, 0, 10, 1, 10, 2, 10, 3, 10, 4, 10, 5, 56, 0, 2]));
		List<TypeTag> ty_args = new List<TypeTag>(1);
		ty_args[0] = token;
		List<TransactionArgument> args = new List<TransactionArgument>(5);
		args[0] = new TransactionArgumentU64Item(voting_delay);
		args[1] = new TransactionArgumentU64Item(voting_period);
		args[2] = new TransactionArgumentU8Item(voting_quorum_rate);
		args[3] = new TransactionArgumentU64Item(min_action_delay);
		args[4] = new TransactionArgumentU64Item(exec_delay);

    var script = new Script(code,ty_args,args);
    return script;
  }

	static Script encode_propose_module_upgrade_script(TypeTag token, AccountAddress module_address, Bytes package_hash, int exec_delay) {

    var code = new Bytes(Uint8List.fromList([-95, 28, -21, 11, 1, 0, 0, 0, 6, 1, 0, 2, 3, 2, 6, 4, 8, 2, 5, 10, 11, 7, 21, 48, 8, 69, 16, 0, 0, 0, 1, 0, 1, 1, 2, 0, 2, 4, 6, 12, 5, 10, 2, 3, 0, 1, 9, 0, 24, 85, 112, 103, 114, 97, 100, 101, 77, 111, 100, 117, 108, 101, 68, 97, 111, 80, 114, 111, 112, 111, 115, 97, 108, 22, 112, 114, 111, 112, 111, 115, 101, 95, 109, 111, 100, 117, 108, 101, 95, 117, 112, 103, 114, 97, 100, 101, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 0, 1, 6, 11, 0, 10, 1, 11, 2, 10, 3, 56, 0, 2]));
		List<TypeTag> ty_args = new List<TypeTag>(1);
		ty_args[0] = token;
		List<TransactionArgument> args = new List<TransactionArgument>(3);
		args[0] = new TransactionArgumentAddressItem(module_address);
		args[1] = new TransactionArgumentU8VectorItem(package_hash);
		args[2] = new TransactionArgumentU64Item(exec_delay);

    var script = new Script(code,ty_args,args);
    return script;
  }

	static Script encode_propose_update_consensus_config_script(int uncle_rate_target, int base_block_time_target, Int128 base_reward_per_block, int base_reward_per_uncle_percent, int epoch_block_count, int base_block_difficulty_window, int min_block_time_target, int max_block_time_target, int base_max_uncles_per_block, int base_block_gas_limit, int strategy, int exec_delay) {

    var code = new Bytes(Uint8List.fromList([-95, 28, -21, 11, 1, 0, 0, 0, 7, 1, 0, 6, 2, 6, 8, 3, 14, 12, 4, 26, 2, 5, 28, 42, 7, 70, 73, 8, -113, 1, 16, 0, 0, 0, 1, 0, 2, 0, 0, 2, 0, 2, 2, 2, 0, 1, 3, 0, 1, 2, 2, 2, 0, 4, 2, 3, 0, 0, 5, 3, 6, 12, 9, 1, 3, 0, 11, 3, 3, 4, 3, 3, 3, 3, 3, 3, 3, 2, 1, 8, 0, 13, 6, 12, 3, 3, 4, 3, 3, 3, 3, 3, 3, 3, 2, 3, 2, 8, 1, 8, 0, 15, 67, 111, 110, 115, 101, 110, 115, 117, 115, 67, 111, 110, 102, 105, 103, 16, 79, 110, 67, 104, 97, 105, 110, 67, 111, 110, 102, 105, 103, 68, 97, 111, 3, 83, 84, 67, 14, 112, 114, 111, 112, 111, 115, 101, 95, 117, 112, 100, 97, 116, 101, 20, 110, 101, 119, 95, 99, 111, 110, 115, 101, 110, 115, 117, 115, 95, 99, 111, 110, 102, 105, 103, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 4, 3, 18, 10, 1, 10, 2, 10, 3, 10, 4, 10, 5, 10, 6, 10, 7, 10, 8, 10, 9, 10, 10, 10, 11, 17, 1, 12, 13, 11, 0, 11, 13, 10, 12, 56, 0, 2]));
		var ty_args = List<TypeTag>();
		List<TransactionArgument> args = new List<TransactionArgument>(12);
		args[0] = new TransactionArgumentU64Item(uncle_rate_target);
		args[1] = new TransactionArgumentU64Item(base_block_time_target);
		args[2] = new TransactionArgumentU128Item(base_reward_per_block);
		args[3] = new TransactionArgumentU64Item(base_reward_per_uncle_percent);
		args[4] = new TransactionArgumentU64Item(epoch_block_count);
		args[5] = new TransactionArgumentU64Item(base_block_difficulty_window);
		args[6] = new TransactionArgumentU64Item(min_block_time_target);
		args[7] = new TransactionArgumentU64Item(max_block_time_target);
		args[8] = new TransactionArgumentU64Item(base_max_uncles_per_block);
		args[9] = new TransactionArgumentU64Item(base_block_gas_limit);
		args[10] = new TransactionArgumentU8Item(strategy);
		args[11] = new TransactionArgumentU64Item(exec_delay);

    var script = new Script(code,ty_args,args);
    return script;
  }

	static Script encode_propose_update_reward_config_script(int reward_delay, int exec_delay) {

    var code = new Bytes(Uint8List.fromList([-95, 28, -21, 11, 1, 0, 0, 0, 7, 1, 0, 6, 2, 6, 8, 3, 14, 12, 4, 26, 2, 5, 28, 22, 7, 50, 67, 8, 117, 16, 0, 0, 0, 1, 0, 2, 1, 1, 2, 0, 2, 2, 2, 0, 0, 3, 0, 1, 2, 2, 2, 1, 4, 2, 3, 0, 0, 5, 3, 6, 12, 9, 1, 3, 0, 1, 3, 1, 8, 0, 3, 6, 12, 3, 3, 2, 8, 1, 8, 0, 16, 79, 110, 67, 104, 97, 105, 110, 67, 111, 110, 102, 105, 103, 68, 97, 111, 12, 82, 101, 119, 97, 114, 100, 67, 111, 110, 102, 105, 103, 3, 83, 84, 67, 14, 112, 114, 111, 112, 111, 115, 101, 95, 117, 112, 100, 97, 116, 101, 17, 110, 101, 119, 95, 114, 101, 119, 97, 114, 100, 95, 99, 111, 110, 102, 105, 103, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 4, 3, 8, 10, 1, 17, 1, 12, 3, 11, 0, 11, 3, 10, 2, 56, 0, 2]));
		var ty_args = List<TypeTag>();
		List<TransactionArgument> args = new List<TransactionArgument>(2);
		args[0] = new TransactionArgumentU64Item(reward_delay);
		args[1] = new TransactionArgumentU64Item(exec_delay);

    var script = new Script(code,ty_args,args);
    return script;
  }

	static Script encode_propose_update_txn_publish_option_script(Bytes script_allow_list, bool module_publishing_allowed, int exec_delay) {

    var code = new Bytes(Uint8List.fromList([-95, 28, -21, 11, 1, 0, 0, 0, 7, 1, 0, 6, 2, 6, 8, 3, 14, 12, 4, 26, 2, 5, 28, 26, 7, 54, 92, 8, -110, 1, 16, 0, 0, 0, 1, 0, 2, 2, 2, 2, 0, 1, 1, 2, 0, 0, 3, 0, 1, 2, 2, 2, 2, 4, 2, 3, 0, 0, 5, 3, 6, 12, 9, 1, 3, 0, 2, 10, 2, 1, 1, 8, 0, 4, 6, 12, 10, 2, 1, 3, 2, 8, 1, 8, 0, 16, 79, 110, 67, 104, 97, 105, 110, 67, 111, 110, 102, 105, 103, 68, 97, 111, 3, 83, 84, 67, 24, 84, 114, 97, 110, 115, 97, 99, 116, 105, 111, 110, 80, 117, 98, 108, 105, 115, 104, 79, 112, 116, 105, 111, 110, 14, 112, 114, 111, 112, 111, 115, 101, 95, 117, 112, 100, 97, 116, 101, 30, 110, 101, 119, 95, 116, 114, 97, 110, 115, 97, 99, 116, 105, 111, 110, 95, 112, 117, 98, 108, 105, 115, 104, 95, 111, 112, 116, 105, 111, 110, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 4, 3, 9, 11, 1, 10, 2, 17, 1, 12, 4, 11, 0, 11, 4, 10, 3, 56, 0, 2]));
		var ty_args = List<TypeTag>();
		List<TransactionArgument> args = new List<TransactionArgument>(3);
		args[0] = new TransactionArgumentU8VectorItem(script_allow_list);
		args[1] = new TransactionArgumentBoolItem(module_publishing_allowed);
		args[2] = new TransactionArgumentU64Item(exec_delay);

    var script = new Script(code,ty_args,args);
    return script;
  }

	static Script encode_propose_update_txn_timeout_config_script(int duration_seconds, int exec_delay) {

    var code = new Bytes(Uint8List.fromList([-95, 28, -21, 11, 1, 0, 0, 0, 7, 1, 0, 6, 2, 6, 8, 3, 14, 12, 4, 26, 2, 5, 28, 22, 7, 50, 92, 8, -114, 1, 16, 0, 0, 0, 1, 0, 2, 2, 2, 2, 0, 1, 1, 2, 0, 0, 3, 0, 1, 2, 2, 2, 2, 4, 2, 3, 0, 0, 5, 3, 6, 12, 9, 1, 3, 0, 1, 3, 1, 8, 0, 3, 6, 12, 3, 3, 2, 8, 1, 8, 0, 16, 79, 110, 67, 104, 97, 105, 110, 67, 111, 110, 102, 105, 103, 68, 97, 111, 3, 83, 84, 67, 24, 84, 114, 97, 110, 115, 97, 99, 116, 105, 111, 110, 84, 105, 109, 101, 111, 117, 116, 67, 111, 110, 102, 105, 103, 14, 112, 114, 111, 112, 111, 115, 101, 95, 117, 112, 100, 97, 116, 101, 30, 110, 101, 119, 95, 116, 114, 97, 110, 115, 97, 99, 116, 105, 111, 110, 95, 116, 105, 109, 101, 111, 117, 116, 95, 99, 111, 110, 102, 105, 103, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 4, 3, 8, 10, 1, 17, 1, 12, 3, 11, 0, 11, 3, 10, 2, 56, 0, 2]));
		var ty_args = List<TypeTag>();
		List<TransactionArgument> args = new List<TransactionArgument>(2);
		args[0] = new TransactionArgumentU64Item(duration_seconds);
		args[1] = new TransactionArgumentU64Item(exec_delay);

    var script = new Script(code,ty_args,args);
    return script;
  }

	static Script encode_propose_update_version_script(int major, int exec_delay) {

    var code = new Bytes(Uint8List.fromList([-95, 28, -21, 11, 1, 0, 0, 0, 7, 1, 0, 6, 2, 6, 8, 3, 14, 12, 4, 26, 2, 5, 28, 22, 7, 50, 56, 8, 106, 16, 0, 0, 0, 1, 0, 2, 2, 2, 2, 0, 1, 1, 2, 0, 0, 3, 0, 1, 2, 2, 2, 2, 4, 2, 3, 0, 0, 5, 3, 6, 12, 9, 1, 3, 0, 1, 3, 1, 8, 0, 3, 6, 12, 3, 3, 2, 8, 1, 8, 0, 16, 79, 110, 67, 104, 97, 105, 110, 67, 111, 110, 102, 105, 103, 68, 97, 111, 3, 83, 84, 67, 7, 86, 101, 114, 115, 105, 111, 110, 14, 112, 114, 111, 112, 111, 115, 101, 95, 117, 112, 100, 97, 116, 101, 11, 110, 101, 119, 95, 118, 101, 114, 115, 105, 111, 110, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 4, 3, 8, 10, 1, 17, 1, 12, 3, 11, 0, 11, 3, 10, 2, 56, 0, 2]));
		var ty_args = List<TypeTag>();
		List<TransactionArgument> args = new List<TransactionArgument>(2);
		args[0] = new TransactionArgumentU64Item(major);
		args[1] = new TransactionArgumentU64Item(exec_delay);

    var script = new Script(code,ty_args,args);
    return script;
  }

	static Script encode_propose_update_vm_config_script(Bytes instruction_schedule, Bytes native_schedule, int global_memory_per_byte_cost, int global_memory_per_byte_write_cost, int min_transaction_gas_units, int large_transaction_cutoff, int instrinsic_gas_per_byte, int maximum_number_of_gas_units, int min_price_per_gas_unit, int max_price_per_gas_unit, int max_transaction_size_in_bytes, int gas_unit_scaling_factor, int default_account_size, int exec_delay) {

    var code = new Bytes(Uint8List.fromList([-95, 28, -21, 11, 1, 0, 0, 0, 7, 1, 0, 6, 2, 6, 8, 3, 14, 12, 4, 26, 2, 5, 28, 50, 7, 78, 59, 8, -119, 1, 16, 0, 0, 0, 1, 0, 2, 2, 2, 2, 0, 1, 1, 2, 0, 0, 3, 0, 1, 2, 2, 2, 2, 4, 2, 3, 0, 0, 5, 3, 6, 12, 9, 1, 3, 0, 13, 10, 2, 10, 2, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 1, 8, 0, 15, 6, 12, 10, 2, 10, 2, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 2, 8, 1, 8, 0, 16, 79, 110, 67, 104, 97, 105, 110, 67, 111, 110, 102, 105, 103, 68, 97, 111, 3, 83, 84, 67, 8, 86, 77, 67, 111, 110, 102, 105, 103, 14, 112, 114, 111, 112, 111, 115, 101, 95, 117, 112, 100, 97, 116, 101, 13, 110, 101, 119, 95, 118, 109, 95, 99, 111, 110, 102, 105, 103, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 4, 3, 20, 11, 1, 11, 2, 10, 3, 10, 4, 10, 5, 10, 6, 10, 7, 10, 8, 10, 9, 10, 10, 10, 11, 10, 12, 10, 13, 17, 1, 12, 15, 11, 0, 11, 15, 10, 14, 56, 0, 2]));
		var ty_args = List<TypeTag>();
		List<TransactionArgument> args = new List<TransactionArgument>(14);
		args[0] = new TransactionArgumentU8VectorItem(instruction_schedule);
		args[1] = new TransactionArgumentU8VectorItem(native_schedule);
		args[2] = new TransactionArgumentU64Item(global_memory_per_byte_cost);
		args[3] = new TransactionArgumentU64Item(global_memory_per_byte_write_cost);
		args[4] = new TransactionArgumentU64Item(min_transaction_gas_units);
		args[5] = new TransactionArgumentU64Item(large_transaction_cutoff);
		args[6] = new TransactionArgumentU64Item(instrinsic_gas_per_byte);
		args[7] = new TransactionArgumentU64Item(maximum_number_of_gas_units);
		args[8] = new TransactionArgumentU64Item(min_price_per_gas_unit);
		args[9] = new TransactionArgumentU64Item(max_price_per_gas_unit);
		args[10] = new TransactionArgumentU64Item(max_transaction_size_in_bytes);
		args[11] = new TransactionArgumentU64Item(gas_unit_scaling_factor);
		args[12] = new TransactionArgumentU64Item(default_account_size);
		args[13] = new TransactionArgumentU64Item(exec_delay);

    var script = new Script(code,ty_args,args);
    return script;
  }

	static Script encode_publish_shared_ed25519_public_key_script(Bytes public_key) {

    var code = new Bytes(Uint8List.fromList([-95, 28, -21, 11, 1, 0, 0, 0, 5, 1, 0, 2, 3, 2, 5, 5, 7, 6, 7, 13, 31, 8, 44, 16, 0, 0, 0, 1, 0, 1, 0, 2, 6, 12, 10, 2, 0, 22, 83, 104, 97, 114, 101, 100, 69, 100, 50, 53, 53, 49, 57, 80, 117, 98, 108, 105, 99, 75, 101, 121, 7, 112, 117, 98, 108, 105, 115, 104, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 4, 11, 0, 11, 1, 17, 0, 2]));
		var ty_args = List<TypeTag>();
		List<TransactionArgument> args = new List<TransactionArgument>(1);
		args[0] = new TransactionArgumentU8VectorItem(public_key);

    var script = new Script(code,ty_args,args);
    return script;
  }

	static Script encode_queue_proposal_action_script(TypeTag token, TypeTag action, AccountAddress proposer_address, int proposal_id) {

    var code = new Bytes(Uint8List.fromList([-95, 28, -21, 11, 1, 0, 0, 0, 6, 1, 0, 2, 3, 2, 7, 4, 9, 2, 5, 11, 14, 7, 25, 26, 8, 51, 16, 0, 0, 0, 1, 0, 1, 2, 2, 1, 0, 3, 2, 5, 3, 0, 3, 6, 12, 5, 3, 2, 9, 0, 9, 1, 3, 68, 97, 111, 21, 113, 117, 101, 117, 101, 95, 112, 114, 111, 112, 111, 115, 97, 108, 95, 97, 99, 116, 105, 111, 110, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 2, 1, 2, 1, 4, 10, 1, 10, 2, 56, 0, 2]));
		List<TypeTag> ty_args = new List<TypeTag>(2);
		ty_args[0] = token;
		ty_args[1] = action;
		List<TransactionArgument> args = new List<TransactionArgument>(2);
		args[0] = new TransactionArgumentAddressItem(proposer_address);
		args[1] = new TransactionArgumentU64Item(proposal_id);

    var script = new Script(code,ty_args,args);
    return script;
  }

	static Script encode_revoke_vote_script(TypeTag token, TypeTag action, AccountAddress proposer_address, int proposal_id) {

    var code = new Bytes(Uint8List.fromList([-95, 28, -21, 11, 1, 0, 0, 0, 7, 1, 0, 8, 2, 8, 5, 3, 13, 24, 4, 37, 6, 5, 43, 53, 7, 96, 64, 8, -96, 1, 16, 0, 0, 0, 1, 0, 2, 0, 3, 3, 3, 1, 1, 1, 2, 4, 0, 1, 0, 0, 5, 2, 3, 1, 1, 1, 6, 4, 5, 2, 2, 1, 1, 7, 6, 7, 1, 2, 3, 10, 2, 11, 1, 10, 1, 6, 12, 1, 5, 2, 5, 11, 0, 1, 9, 0, 0, 4, 6, 12, 5, 3, 4, 1, 11, 0, 1, 9, 0, 3, 5, 5, 3, 2, 1, 4, 3, 6, 12, 5, 3, 3, 11, 0, 1, 9, 0, 4, 5, 1, 9, 0, 2, 9, 0, 9, 1, 7, 65, 99, 99, 111, 117, 110, 116, 3, 68, 97, 111, 6, 83, 105, 103, 110, 101, 114, 5, 84, 111, 107, 101, 110, 10, 97, 100, 100, 114, 101, 115, 115, 95, 111, 102, 7, 100, 101, 112, 111, 115, 105, 116, 11, 114, 101, 118, 111, 107, 101, 95, 118, 111, 116, 101, 7, 118, 111, 116, 101, 95, 111, 102, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 2, 1, 8, 9, 19, 10, 0, 17, 0, 12, 5, 10, 5, 10, 1, 10, 2, 56, 0, 12, 4, 1, 11, 0, 10, 1, 10, 2, 10, 4, 56, 1, 12, 3, 10, 5, 11, 3, 56, 2, 2]));
		List<TypeTag> ty_args = new List<TypeTag>(2);
		ty_args[0] = token;
		ty_args[1] = action;
		List<TransactionArgument> args = new List<TransactionArgument>(2);
		args[0] = new TransactionArgumentAddressItem(proposer_address);
		args[1] = new TransactionArgumentU64Item(proposal_id);

    var script = new Script(code,ty_args,args);
    return script;
  }

	static Script encode_submit_module_upgrade_plan_script(TypeTag token, AccountAddress proposer_address, int proposal_id) {

    var code = new Bytes(Uint8List.fromList([-95, 28, -21, 11, 1, 0, 0, 0, 6, 1, 0, 2, 3, 2, 6, 4, 8, 2, 5, 10, 12, 7, 22, 52, 8, 74, 16, 0, 0, 0, 1, 0, 1, 1, 2, 0, 3, 2, 5, 3, 0, 3, 6, 12, 5, 3, 1, 9, 0, 24, 85, 112, 103, 114, 97, 100, 101, 77, 111, 100, 117, 108, 101, 68, 97, 111, 80, 114, 111, 112, 111, 115, 97, 108, 26, 115, 117, 98, 109, 105, 116, 95, 109, 111, 100, 117, 108, 101, 95, 117, 112, 103, 114, 97, 100, 101, 95, 112, 108, 97, 110, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 1, 4, 10, 1, 10, 2, 56, 0, 2]));
		List<TypeTag> ty_args = new List<TypeTag>(1);
		ty_args[0] = token;
		List<TransactionArgument> args = new List<TransactionArgument>(2);
		args[0] = new TransactionArgumentAddressItem(proposer_address);
		args[1] = new TransactionArgumentU64Item(proposal_id);

    var script = new Script(code,ty_args,args);
    return script;
  }

	static Script encode_unstake_vote_script(TypeTag token, TypeTag action, AccountAddress proposer_address, int proposal_id) {

    var code = new Bytes(Uint8List.fromList([-95, 28, -21, 11, 1, 0, 0, 0, 7, 1, 0, 8, 2, 8, 5, 3, 13, 18, 4, 31, 4, 5, 35, 32, 7, 67, 58, 8, 125, 16, 0, 0, 0, 1, 0, 2, 0, 3, 3, 3, 1, 1, 1, 2, 4, 0, 1, 0, 0, 5, 2, 3, 1, 1, 1, 6, 4, 5, 2, 2, 1, 2, 6, 1, 7, 1, 6, 12, 1, 5, 2, 5, 11, 0, 1, 9, 0, 0, 3, 6, 12, 5, 3, 1, 11, 0, 1, 9, 0, 2, 9, 0, 9, 1, 1, 9, 0, 7, 65, 99, 99, 111, 117, 110, 116, 3, 68, 97, 111, 6, 83, 105, 103, 110, 101, 114, 5, 84, 111, 107, 101, 110, 10, 97, 100, 100, 114, 101, 115, 115, 95, 111, 102, 7, 100, 101, 112, 111, 115, 105, 116, 13, 117, 110, 115, 116, 97, 107, 101, 95, 118, 111, 116, 101, 115, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 2, 1, 4, 5, 10, 10, 0, 10, 1, 10, 2, 56, 0, 12, 3, 11, 0, 17, 0, 11, 3, 56, 1, 2]));
		List<TypeTag> ty_args = new List<TypeTag>(2);
		ty_args[0] = token;
		ty_args[1] = action;
		List<TransactionArgument> args = new List<TransactionArgument>(2);
		args[0] = new TransactionArgumentAddressItem(proposer_address);
		args[1] = new TransactionArgumentU64Item(proposal_id);

    var script = new Script(code,ty_args,args);
    return script;
  }

}

