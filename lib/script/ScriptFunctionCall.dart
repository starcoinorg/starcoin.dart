part of script_types;

abstract class ScriptFunctionCall {
  ScriptFunctionCall();
}


class ScriptFunctionCallAcceptTokenItem extends ScriptFunctionCall {
  TypeTag token_type;

  ScriptFunctionCallAcceptTokenItem(TypeTag token_type) {
    assert (token_type != null);
    this.token_type = token_type;
  }

  @override
  bool operator ==(covariant ScriptFunctionCallAcceptTokenItem other) {
    if (other == null) return false;

    if (  this.token_type == other.token_type  ){
    return true;}
    else return false;
  }

  @override
  int get hashCode {
    int value = 7;
    value = 31 * value + (this.token_type != null ? this.token_type.hashCode : 0);
    return value;
  }

  ScriptFunctionCallAcceptTokenItem.loadJson(dynamic json) :
    token_type = TypeTag.fromJson(json['token_type']) ;

  dynamic toJson() => {
    "token_type" : token_type.toJson() ,
    "type" : 0,
    "type_name" : "AcceptToken"
  };
}

class ScriptFunctionCallCancelUpgradePlanItem extends ScriptFunctionCall {
  ScriptFunctionCallCancelUpgradePlanItem() {
  }

  @override
  bool operator ==(covariant ScriptFunctionCallCancelUpgradePlanItem other) {
    if (other == null) return false;
    return true;
  }

  @override
  int get hashCode {
    int value = 7;
    return value;
  }

  ScriptFunctionCallCancelUpgradePlanItem.loadJson(dynamic json);

  dynamic toJson() => {
    "type" : 1,
    "type_name" : "CancelUpgradePlan"
  };
}

class ScriptFunctionCallCastVoteItem extends ScriptFunctionCall {
  TypeTag token;
  TypeTag action_t;
  AccountAddress proposer_address;
  int proposal_id;
  bool agree;
  Int128 votes;

  ScriptFunctionCallCastVoteItem(TypeTag token, TypeTag action_t, AccountAddress proposer_address, int proposal_id, bool agree, Int128 votes) {
    assert (token != null);
    assert (action_t != null);
    assert (proposer_address != null);
    assert (proposal_id != null);
    assert (agree != null);
    assert (votes != null);
    this.token = token;
    this.action_t = action_t;
    this.proposer_address = proposer_address;
    this.proposal_id = proposal_id;
    this.agree = agree;
    this.votes = votes;
  }

  @override
  bool operator ==(covariant ScriptFunctionCallCastVoteItem other) {
    if (other == null) return false;

    if (  this.token == other.token  &&
      this.action_t == other.action_t  &&
      this.proposer_address == other.proposer_address  &&
      this.proposal_id == other.proposal_id  &&
      this.agree == other.agree  &&
      this.votes == other.votes  ){
    return true;}
    else return false;
  }

  @override
  int get hashCode {
    int value = 7;
    value = 31 * value + (this.token != null ? this.token.hashCode : 0);
    value = 31 * value + (this.action_t != null ? this.action_t.hashCode : 0);
    value = 31 * value + (this.proposer_address != null ? this.proposer_address.hashCode : 0);
    value = 31 * value + (this.proposal_id != null ? this.proposal_id.hashCode : 0);
    value = 31 * value + (this.agree != null ? this.agree.hashCode : 0);
    value = 31 * value + (this.votes != null ? this.votes.hashCode : 0);
    return value;
  }

  ScriptFunctionCallCastVoteItem.loadJson(dynamic json) :
    token = TypeTag.fromJson(json['token']) ,
    action_t = TypeTag.fromJson(json['action_t']) ,
    proposer_address = AccountAddress.fromJson(json['proposer_address']) ,
    proposal_id = json['proposal_id'] ,
    agree = json['agree'] ,
    votes = json['votes'] ;

  dynamic toJson() => {
    "token" : token.toJson() ,
    "action_t" : action_t.toJson() ,
    "proposer_address" : proposer_address.toJson() ,
    "proposal_id" : proposal_id ,
    "agree" : agree ,
    "votes" : votes ,
    "type" : 2,
    "type_name" : "CastVote"
  };
}

class ScriptFunctionCallCreateAccountWithInitialAmountItem extends ScriptFunctionCall {
  TypeTag token_type;
  AccountAddress fresh_address;
  Bytes auth_key;
  Int128 initial_amount;

  ScriptFunctionCallCreateAccountWithInitialAmountItem(TypeTag token_type, AccountAddress fresh_address, Bytes auth_key, Int128 initial_amount) {
    assert (token_type != null);
    assert (fresh_address != null);
    assert (auth_key != null);
    assert (initial_amount != null);
    this.token_type = token_type;
    this.fresh_address = fresh_address;
    this.auth_key = auth_key;
    this.initial_amount = initial_amount;
  }

  @override
  bool operator ==(covariant ScriptFunctionCallCreateAccountWithInitialAmountItem other) {
    if (other == null) return false;

    if (  this.token_type == other.token_type  &&
      this.fresh_address == other.fresh_address  &&
      this.auth_key == other.auth_key  &&
      this.initial_amount == other.initial_amount  ){
    return true;}
    else return false;
  }

  @override
  int get hashCode {
    int value = 7;
    value = 31 * value + (this.token_type != null ? this.token_type.hashCode : 0);
    value = 31 * value + (this.fresh_address != null ? this.fresh_address.hashCode : 0);
    value = 31 * value + (this.auth_key != null ? this.auth_key.hashCode : 0);
    value = 31 * value + (this.initial_amount != null ? this.initial_amount.hashCode : 0);
    return value;
  }

  ScriptFunctionCallCreateAccountWithInitialAmountItem.loadJson(dynamic json) :
    token_type = TypeTag.fromJson(json['token_type']) ,
    fresh_address = AccountAddress.fromJson(json['fresh_address']) ,
    auth_key = Bytes.fromJson(json['auth_key']) ,
    initial_amount = json['initial_amount'] ;

  dynamic toJson() => {
    "token_type" : token_type.toJson() ,
    "fresh_address" : fresh_address.toJson() ,
    "auth_key" : auth_key.toJson() ,
    "initial_amount" : initial_amount ,
    "type" : 3,
    "type_name" : "CreateAccountWithInitialAmount"
  };
}

class ScriptFunctionCallDestroyTerminatedProposalItem extends ScriptFunctionCall {
  TypeTag token_t;
  TypeTag action_t;
  AccountAddress proposer_address;
  int proposal_id;

  ScriptFunctionCallDestroyTerminatedProposalItem(TypeTag token_t, TypeTag action_t, AccountAddress proposer_address, int proposal_id) {
    assert (token_t != null);
    assert (action_t != null);
    assert (proposer_address != null);
    assert (proposal_id != null);
    this.token_t = token_t;
    this.action_t = action_t;
    this.proposer_address = proposer_address;
    this.proposal_id = proposal_id;
  }

  @override
  bool operator ==(covariant ScriptFunctionCallDestroyTerminatedProposalItem other) {
    if (other == null) return false;

    if (  this.token_t == other.token_t  &&
      this.action_t == other.action_t  &&
      this.proposer_address == other.proposer_address  &&
      this.proposal_id == other.proposal_id  ){
    return true;}
    else return false;
  }

  @override
  int get hashCode {
    int value = 7;
    value = 31 * value + (this.token_t != null ? this.token_t.hashCode : 0);
    value = 31 * value + (this.action_t != null ? this.action_t.hashCode : 0);
    value = 31 * value + (this.proposer_address != null ? this.proposer_address.hashCode : 0);
    value = 31 * value + (this.proposal_id != null ? this.proposal_id.hashCode : 0);
    return value;
  }

  ScriptFunctionCallDestroyTerminatedProposalItem.loadJson(dynamic json) :
    token_t = TypeTag.fromJson(json['token_t']) ,
    action_t = TypeTag.fromJson(json['action_t']) ,
    proposer_address = AccountAddress.fromJson(json['proposer_address']) ,
    proposal_id = json['proposal_id'] ;

  dynamic toJson() => {
    "token_t" : token_t.toJson() ,
    "action_t" : action_t.toJson() ,
    "proposer_address" : proposer_address.toJson() ,
    "proposal_id" : proposal_id ,
    "type" : 4,
    "type_name" : "DestroyTerminatedProposal"
  };
}

class ScriptFunctionCallExecuteItem extends ScriptFunctionCall {
  TypeTag token_t;
  AccountAddress proposer_address;
  int proposal_id;

  ScriptFunctionCallExecuteItem(TypeTag token_t, AccountAddress proposer_address, int proposal_id) {
    assert (token_t != null);
    assert (proposer_address != null);
    assert (proposal_id != null);
    this.token_t = token_t;
    this.proposer_address = proposer_address;
    this.proposal_id = proposal_id;
  }

  @override
  bool operator ==(covariant ScriptFunctionCallExecuteItem other) {
    if (other == null) return false;

    if (  this.token_t == other.token_t  &&
      this.proposer_address == other.proposer_address  &&
      this.proposal_id == other.proposal_id  ){
    return true;}
    else return false;
  }

  @override
  int get hashCode {
    int value = 7;
    value = 31 * value + (this.token_t != null ? this.token_t.hashCode : 0);
    value = 31 * value + (this.proposer_address != null ? this.proposer_address.hashCode : 0);
    value = 31 * value + (this.proposal_id != null ? this.proposal_id.hashCode : 0);
    return value;
  }

  ScriptFunctionCallExecuteItem.loadJson(dynamic json) :
    token_t = TypeTag.fromJson(json['token_t']) ,
    proposer_address = AccountAddress.fromJson(json['proposer_address']) ,
    proposal_id = json['proposal_id'] ;

  dynamic toJson() => {
    "token_t" : token_t.toJson() ,
    "proposer_address" : proposer_address.toJson() ,
    "proposal_id" : proposal_id ,
    "type" : 5,
    "type_name" : "Execute"
  };
}

class ScriptFunctionCallExecuteOnChainConfigProposalItem extends ScriptFunctionCall {
  TypeTag config_t;
  int proposal_id;

  ScriptFunctionCallExecuteOnChainConfigProposalItem(TypeTag config_t, int proposal_id) {
    assert (config_t != null);
    assert (proposal_id != null);
    this.config_t = config_t;
    this.proposal_id = proposal_id;
  }

  @override
  bool operator ==(covariant ScriptFunctionCallExecuteOnChainConfigProposalItem other) {
    if (other == null) return false;

    if (  this.config_t == other.config_t  &&
      this.proposal_id == other.proposal_id  ){
    return true;}
    else return false;
  }

  @override
  int get hashCode {
    int value = 7;
    value = 31 * value + (this.config_t != null ? this.config_t.hashCode : 0);
    value = 31 * value + (this.proposal_id != null ? this.proposal_id.hashCode : 0);
    return value;
  }

  ScriptFunctionCallExecuteOnChainConfigProposalItem.loadJson(dynamic json) :
    config_t = TypeTag.fromJson(json['config_t']) ,
    proposal_id = json['proposal_id'] ;

  dynamic toJson() => {
    "config_t" : config_t.toJson() ,
    "proposal_id" : proposal_id ,
    "type" : 6,
    "type_name" : "ExecuteOnChainConfigProposal"
  };
}

class ScriptFunctionCallInitializeItem extends ScriptFunctionCall {
  int stdlib_version;
  int reward_delay;
  Int128 pre_mine_amount;
  Int128 time_mint_amount;
  int time_mint_period;
  Bytes parent_hash;
  Bytes association_auth_key;
  Bytes genesis_auth_key;
  int chain_id;
  int genesis_timestamp;
  int uncle_rate_target;
  int epoch_block_count;
  int base_block_time_target;
  int base_block_difficulty_window;
  Int128 base_reward_per_block;
  int base_reward_per_uncle_percent;
  int min_block_time_target;
  int max_block_time_target;
  int base_max_uncles_per_block;
  int base_block_gas_limit;
  int strategy;
  Bytes merged_script_allow_list;
  bool is_open_module;
  Bytes instruction_schedule;
  Bytes native_schedule;
  int global_memory_per_byte_cost;
  int global_memory_per_byte_write_cost;
  int min_transaction_gas_units;
  int large_transaction_cutoff;
  int instrinsic_gas_per_byte;
  int maximum_number_of_gas_units;
  int min_price_per_gas_unit;
  int max_price_per_gas_unit;
  int max_transaction_size_in_bytes;
  int gas_unit_scaling_factor;
  int default_account_size;
  int voting_delay;
  int voting_period;
  int voting_quorum_rate;
  int min_action_delay;
  int transaction_timeout;

  ScriptFunctionCallInitializeItem(int stdlib_version, int reward_delay, Int128 pre_mine_amount, Int128 time_mint_amount, int time_mint_period, Bytes parent_hash, Bytes association_auth_key, Bytes genesis_auth_key, int chain_id, int genesis_timestamp, int uncle_rate_target, int epoch_block_count, int base_block_time_target, int base_block_difficulty_window, Int128 base_reward_per_block, int base_reward_per_uncle_percent, int min_block_time_target, int max_block_time_target, int base_max_uncles_per_block, int base_block_gas_limit, int strategy, Bytes merged_script_allow_list, bool is_open_module, Bytes instruction_schedule, Bytes native_schedule, int global_memory_per_byte_cost, int global_memory_per_byte_write_cost, int min_transaction_gas_units, int large_transaction_cutoff, int instrinsic_gas_per_byte, int maximum_number_of_gas_units, int min_price_per_gas_unit, int max_price_per_gas_unit, int max_transaction_size_in_bytes, int gas_unit_scaling_factor, int default_account_size, int voting_delay, int voting_period, int voting_quorum_rate, int min_action_delay, int transaction_timeout) {
    assert (stdlib_version != null);
    assert (reward_delay != null);
    assert (pre_mine_amount != null);
    assert (time_mint_amount != null);
    assert (time_mint_period != null);
    assert (parent_hash != null);
    assert (association_auth_key != null);
    assert (genesis_auth_key != null);
    assert (chain_id != null);
    assert (genesis_timestamp != null);
    assert (uncle_rate_target != null);
    assert (epoch_block_count != null);
    assert (base_block_time_target != null);
    assert (base_block_difficulty_window != null);
    assert (base_reward_per_block != null);
    assert (base_reward_per_uncle_percent != null);
    assert (min_block_time_target != null);
    assert (max_block_time_target != null);
    assert (base_max_uncles_per_block != null);
    assert (base_block_gas_limit != null);
    assert (strategy != null);
    assert (merged_script_allow_list != null);
    assert (is_open_module != null);
    assert (instruction_schedule != null);
    assert (native_schedule != null);
    assert (global_memory_per_byte_cost != null);
    assert (global_memory_per_byte_write_cost != null);
    assert (min_transaction_gas_units != null);
    assert (large_transaction_cutoff != null);
    assert (instrinsic_gas_per_byte != null);
    assert (maximum_number_of_gas_units != null);
    assert (min_price_per_gas_unit != null);
    assert (max_price_per_gas_unit != null);
    assert (max_transaction_size_in_bytes != null);
    assert (gas_unit_scaling_factor != null);
    assert (default_account_size != null);
    assert (voting_delay != null);
    assert (voting_period != null);
    assert (voting_quorum_rate != null);
    assert (min_action_delay != null);
    assert (transaction_timeout != null);
    this.stdlib_version = stdlib_version;
    this.reward_delay = reward_delay;
    this.pre_mine_amount = pre_mine_amount;
    this.time_mint_amount = time_mint_amount;
    this.time_mint_period = time_mint_period;
    this.parent_hash = parent_hash;
    this.association_auth_key = association_auth_key;
    this.genesis_auth_key = genesis_auth_key;
    this.chain_id = chain_id;
    this.genesis_timestamp = genesis_timestamp;
    this.uncle_rate_target = uncle_rate_target;
    this.epoch_block_count = epoch_block_count;
    this.base_block_time_target = base_block_time_target;
    this.base_block_difficulty_window = base_block_difficulty_window;
    this.base_reward_per_block = base_reward_per_block;
    this.base_reward_per_uncle_percent = base_reward_per_uncle_percent;
    this.min_block_time_target = min_block_time_target;
    this.max_block_time_target = max_block_time_target;
    this.base_max_uncles_per_block = base_max_uncles_per_block;
    this.base_block_gas_limit = base_block_gas_limit;
    this.strategy = strategy;
    this.merged_script_allow_list = merged_script_allow_list;
    this.is_open_module = is_open_module;
    this.instruction_schedule = instruction_schedule;
    this.native_schedule = native_schedule;
    this.global_memory_per_byte_cost = global_memory_per_byte_cost;
    this.global_memory_per_byte_write_cost = global_memory_per_byte_write_cost;
    this.min_transaction_gas_units = min_transaction_gas_units;
    this.large_transaction_cutoff = large_transaction_cutoff;
    this.instrinsic_gas_per_byte = instrinsic_gas_per_byte;
    this.maximum_number_of_gas_units = maximum_number_of_gas_units;
    this.min_price_per_gas_unit = min_price_per_gas_unit;
    this.max_price_per_gas_unit = max_price_per_gas_unit;
    this.max_transaction_size_in_bytes = max_transaction_size_in_bytes;
    this.gas_unit_scaling_factor = gas_unit_scaling_factor;
    this.default_account_size = default_account_size;
    this.voting_delay = voting_delay;
    this.voting_period = voting_period;
    this.voting_quorum_rate = voting_quorum_rate;
    this.min_action_delay = min_action_delay;
    this.transaction_timeout = transaction_timeout;
  }

  @override
  bool operator ==(covariant ScriptFunctionCallInitializeItem other) {
    if (other == null) return false;

    if (  this.stdlib_version == other.stdlib_version  &&
      this.reward_delay == other.reward_delay  &&
      this.pre_mine_amount == other.pre_mine_amount  &&
      this.time_mint_amount == other.time_mint_amount  &&
      this.time_mint_period == other.time_mint_period  &&
      this.parent_hash == other.parent_hash  &&
      this.association_auth_key == other.association_auth_key  &&
      this.genesis_auth_key == other.genesis_auth_key  &&
      this.chain_id == other.chain_id  &&
      this.genesis_timestamp == other.genesis_timestamp  &&
      this.uncle_rate_target == other.uncle_rate_target  &&
      this.epoch_block_count == other.epoch_block_count  &&
      this.base_block_time_target == other.base_block_time_target  &&
      this.base_block_difficulty_window == other.base_block_difficulty_window  &&
      this.base_reward_per_block == other.base_reward_per_block  &&
      this.base_reward_per_uncle_percent == other.base_reward_per_uncle_percent  &&
      this.min_block_time_target == other.min_block_time_target  &&
      this.max_block_time_target == other.max_block_time_target  &&
      this.base_max_uncles_per_block == other.base_max_uncles_per_block  &&
      this.base_block_gas_limit == other.base_block_gas_limit  &&
      this.strategy == other.strategy  &&
      this.merged_script_allow_list == other.merged_script_allow_list  &&
      this.is_open_module == other.is_open_module  &&
      this.instruction_schedule == other.instruction_schedule  &&
      this.native_schedule == other.native_schedule  &&
      this.global_memory_per_byte_cost == other.global_memory_per_byte_cost  &&
      this.global_memory_per_byte_write_cost == other.global_memory_per_byte_write_cost  &&
      this.min_transaction_gas_units == other.min_transaction_gas_units  &&
      this.large_transaction_cutoff == other.large_transaction_cutoff  &&
      this.instrinsic_gas_per_byte == other.instrinsic_gas_per_byte  &&
      this.maximum_number_of_gas_units == other.maximum_number_of_gas_units  &&
      this.min_price_per_gas_unit == other.min_price_per_gas_unit  &&
      this.max_price_per_gas_unit == other.max_price_per_gas_unit  &&
      this.max_transaction_size_in_bytes == other.max_transaction_size_in_bytes  &&
      this.gas_unit_scaling_factor == other.gas_unit_scaling_factor  &&
      this.default_account_size == other.default_account_size  &&
      this.voting_delay == other.voting_delay  &&
      this.voting_period == other.voting_period  &&
      this.voting_quorum_rate == other.voting_quorum_rate  &&
      this.min_action_delay == other.min_action_delay  &&
      this.transaction_timeout == other.transaction_timeout  ){
    return true;}
    else return false;
  }

  @override
  int get hashCode {
    int value = 7;
    value = 31 * value + (this.stdlib_version != null ? this.stdlib_version.hashCode : 0);
    value = 31 * value + (this.reward_delay != null ? this.reward_delay.hashCode : 0);
    value = 31 * value + (this.pre_mine_amount != null ? this.pre_mine_amount.hashCode : 0);
    value = 31 * value + (this.time_mint_amount != null ? this.time_mint_amount.hashCode : 0);
    value = 31 * value + (this.time_mint_period != null ? this.time_mint_period.hashCode : 0);
    value = 31 * value + (this.parent_hash != null ? this.parent_hash.hashCode : 0);
    value = 31 * value + (this.association_auth_key != null ? this.association_auth_key.hashCode : 0);
    value = 31 * value + (this.genesis_auth_key != null ? this.genesis_auth_key.hashCode : 0);
    value = 31 * value + (this.chain_id != null ? this.chain_id.hashCode : 0);
    value = 31 * value + (this.genesis_timestamp != null ? this.genesis_timestamp.hashCode : 0);
    value = 31 * value + (this.uncle_rate_target != null ? this.uncle_rate_target.hashCode : 0);
    value = 31 * value + (this.epoch_block_count != null ? this.epoch_block_count.hashCode : 0);
    value = 31 * value + (this.base_block_time_target != null ? this.base_block_time_target.hashCode : 0);
    value = 31 * value + (this.base_block_difficulty_window != null ? this.base_block_difficulty_window.hashCode : 0);
    value = 31 * value + (this.base_reward_per_block != null ? this.base_reward_per_block.hashCode : 0);
    value = 31 * value + (this.base_reward_per_uncle_percent != null ? this.base_reward_per_uncle_percent.hashCode : 0);
    value = 31 * value + (this.min_block_time_target != null ? this.min_block_time_target.hashCode : 0);
    value = 31 * value + (this.max_block_time_target != null ? this.max_block_time_target.hashCode : 0);
    value = 31 * value + (this.base_max_uncles_per_block != null ? this.base_max_uncles_per_block.hashCode : 0);
    value = 31 * value + (this.base_block_gas_limit != null ? this.base_block_gas_limit.hashCode : 0);
    value = 31 * value + (this.strategy != null ? this.strategy.hashCode : 0);
    value = 31 * value + (this.merged_script_allow_list != null ? this.merged_script_allow_list.hashCode : 0);
    value = 31 * value + (this.is_open_module != null ? this.is_open_module.hashCode : 0);
    value = 31 * value + (this.instruction_schedule != null ? this.instruction_schedule.hashCode : 0);
    value = 31 * value + (this.native_schedule != null ? this.native_schedule.hashCode : 0);
    value = 31 * value + (this.global_memory_per_byte_cost != null ? this.global_memory_per_byte_cost.hashCode : 0);
    value = 31 * value + (this.global_memory_per_byte_write_cost != null ? this.global_memory_per_byte_write_cost.hashCode : 0);
    value = 31 * value + (this.min_transaction_gas_units != null ? this.min_transaction_gas_units.hashCode : 0);
    value = 31 * value + (this.large_transaction_cutoff != null ? this.large_transaction_cutoff.hashCode : 0);
    value = 31 * value + (this.instrinsic_gas_per_byte != null ? this.instrinsic_gas_per_byte.hashCode : 0);
    value = 31 * value + (this.maximum_number_of_gas_units != null ? this.maximum_number_of_gas_units.hashCode : 0);
    value = 31 * value + (this.min_price_per_gas_unit != null ? this.min_price_per_gas_unit.hashCode : 0);
    value = 31 * value + (this.max_price_per_gas_unit != null ? this.max_price_per_gas_unit.hashCode : 0);
    value = 31 * value + (this.max_transaction_size_in_bytes != null ? this.max_transaction_size_in_bytes.hashCode : 0);
    value = 31 * value + (this.gas_unit_scaling_factor != null ? this.gas_unit_scaling_factor.hashCode : 0);
    value = 31 * value + (this.default_account_size != null ? this.default_account_size.hashCode : 0);
    value = 31 * value + (this.voting_delay != null ? this.voting_delay.hashCode : 0);
    value = 31 * value + (this.voting_period != null ? this.voting_period.hashCode : 0);
    value = 31 * value + (this.voting_quorum_rate != null ? this.voting_quorum_rate.hashCode : 0);
    value = 31 * value + (this.min_action_delay != null ? this.min_action_delay.hashCode : 0);
    value = 31 * value + (this.transaction_timeout != null ? this.transaction_timeout.hashCode : 0);
    return value;
  }

  ScriptFunctionCallInitializeItem.loadJson(dynamic json) :
    stdlib_version = json['stdlib_version'] ,
    reward_delay = json['reward_delay'] ,
    pre_mine_amount = json['pre_mine_amount'] ,
    time_mint_amount = json['time_mint_amount'] ,
    time_mint_period = json['time_mint_period'] ,
    parent_hash = Bytes.fromJson(json['parent_hash']) ,
    association_auth_key = Bytes.fromJson(json['association_auth_key']) ,
    genesis_auth_key = Bytes.fromJson(json['genesis_auth_key']) ,
    chain_id = json['chain_id'] ,
    genesis_timestamp = json['genesis_timestamp'] ,
    uncle_rate_target = json['uncle_rate_target'] ,
    epoch_block_count = json['epoch_block_count'] ,
    base_block_time_target = json['base_block_time_target'] ,
    base_block_difficulty_window = json['base_block_difficulty_window'] ,
    base_reward_per_block = json['base_reward_per_block'] ,
    base_reward_per_uncle_percent = json['base_reward_per_uncle_percent'] ,
    min_block_time_target = json['min_block_time_target'] ,
    max_block_time_target = json['max_block_time_target'] ,
    base_max_uncles_per_block = json['base_max_uncles_per_block'] ,
    base_block_gas_limit = json['base_block_gas_limit'] ,
    strategy = json['strategy'] ,
    merged_script_allow_list = Bytes.fromJson(json['merged_script_allow_list']) ,
    is_open_module = json['is_open_module'] ,
    instruction_schedule = Bytes.fromJson(json['instruction_schedule']) ,
    native_schedule = Bytes.fromJson(json['native_schedule']) ,
    global_memory_per_byte_cost = json['global_memory_per_byte_cost'] ,
    global_memory_per_byte_write_cost = json['global_memory_per_byte_write_cost'] ,
    min_transaction_gas_units = json['min_transaction_gas_units'] ,
    large_transaction_cutoff = json['large_transaction_cutoff'] ,
    instrinsic_gas_per_byte = json['instrinsic_gas_per_byte'] ,
    maximum_number_of_gas_units = json['maximum_number_of_gas_units'] ,
    min_price_per_gas_unit = json['min_price_per_gas_unit'] ,
    max_price_per_gas_unit = json['max_price_per_gas_unit'] ,
    max_transaction_size_in_bytes = json['max_transaction_size_in_bytes'] ,
    gas_unit_scaling_factor = json['gas_unit_scaling_factor'] ,
    default_account_size = json['default_account_size'] ,
    voting_delay = json['voting_delay'] ,
    voting_period = json['voting_period'] ,
    voting_quorum_rate = json['voting_quorum_rate'] ,
    min_action_delay = json['min_action_delay'] ,
    transaction_timeout = json['transaction_timeout'] ;

  dynamic toJson() => {
    "stdlib_version" : stdlib_version ,
    "reward_delay" : reward_delay ,
    "pre_mine_amount" : pre_mine_amount ,
    "time_mint_amount" : time_mint_amount ,
    "time_mint_period" : time_mint_period ,
    "parent_hash" : parent_hash.toJson() ,
    "association_auth_key" : association_auth_key.toJson() ,
    "genesis_auth_key" : genesis_auth_key.toJson() ,
    "chain_id" : chain_id ,
    "genesis_timestamp" : genesis_timestamp ,
    "uncle_rate_target" : uncle_rate_target ,
    "epoch_block_count" : epoch_block_count ,
    "base_block_time_target" : base_block_time_target ,
    "base_block_difficulty_window" : base_block_difficulty_window ,
    "base_reward_per_block" : base_reward_per_block ,
    "base_reward_per_uncle_percent" : base_reward_per_uncle_percent ,
    "min_block_time_target" : min_block_time_target ,
    "max_block_time_target" : max_block_time_target ,
    "base_max_uncles_per_block" : base_max_uncles_per_block ,
    "base_block_gas_limit" : base_block_gas_limit ,
    "strategy" : strategy ,
    "merged_script_allow_list" : merged_script_allow_list.toJson() ,
    "is_open_module" : is_open_module ,
    "instruction_schedule" : instruction_schedule.toJson() ,
    "native_schedule" : native_schedule.toJson() ,
    "global_memory_per_byte_cost" : global_memory_per_byte_cost ,
    "global_memory_per_byte_write_cost" : global_memory_per_byte_write_cost ,
    "min_transaction_gas_units" : min_transaction_gas_units ,
    "large_transaction_cutoff" : large_transaction_cutoff ,
    "instrinsic_gas_per_byte" : instrinsic_gas_per_byte ,
    "maximum_number_of_gas_units" : maximum_number_of_gas_units ,
    "min_price_per_gas_unit" : min_price_per_gas_unit ,
    "max_price_per_gas_unit" : max_price_per_gas_unit ,
    "max_transaction_size_in_bytes" : max_transaction_size_in_bytes ,
    "gas_unit_scaling_factor" : gas_unit_scaling_factor ,
    "default_account_size" : default_account_size ,
    "voting_delay" : voting_delay ,
    "voting_period" : voting_period ,
    "voting_quorum_rate" : voting_quorum_rate ,
    "min_action_delay" : min_action_delay ,
    "transaction_timeout" : transaction_timeout ,
    "type" : 7,
    "type_name" : "Initialize"
  };
}

class ScriptFunctionCallMintAndSplitByLinearKeyItem extends ScriptFunctionCall {
  TypeTag token;
  AccountAddress for_address;
  Int128 amount;
  int lock_period;

  ScriptFunctionCallMintAndSplitByLinearKeyItem(TypeTag token, AccountAddress for_address, Int128 amount, int lock_period) {
    assert (token != null);
    assert (for_address != null);
    assert (amount != null);
    assert (lock_period != null);
    this.token = token;
    this.for_address = for_address;
    this.amount = amount;
    this.lock_period = lock_period;
  }

  @override
  bool operator ==(covariant ScriptFunctionCallMintAndSplitByLinearKeyItem other) {
    if (other == null) return false;

    if (  this.token == other.token  &&
      this.for_address == other.for_address  &&
      this.amount == other.amount  &&
      this.lock_period == other.lock_period  ){
    return true;}
    else return false;
  }

  @override
  int get hashCode {
    int value = 7;
    value = 31 * value + (this.token != null ? this.token.hashCode : 0);
    value = 31 * value + (this.for_address != null ? this.for_address.hashCode : 0);
    value = 31 * value + (this.amount != null ? this.amount.hashCode : 0);
    value = 31 * value + (this.lock_period != null ? this.lock_period.hashCode : 0);
    return value;
  }

  ScriptFunctionCallMintAndSplitByLinearKeyItem.loadJson(dynamic json) :
    token = TypeTag.fromJson(json['token']) ,
    for_address = AccountAddress.fromJson(json['for_address']) ,
    amount = json['amount'] ,
    lock_period = json['lock_period'] ;

  dynamic toJson() => {
    "token" : token.toJson() ,
    "for_address" : for_address.toJson() ,
    "amount" : amount ,
    "lock_period" : lock_period ,
    "type" : 8,
    "type_name" : "MintAndSplitByLinearKey"
  };
}

class ScriptFunctionCallMintTokenByFixedKeyItem extends ScriptFunctionCall {
  TypeTag token;

  ScriptFunctionCallMintTokenByFixedKeyItem(TypeTag token) {
    assert (token != null);
    this.token = token;
  }

  @override
  bool operator ==(covariant ScriptFunctionCallMintTokenByFixedKeyItem other) {
    if (other == null) return false;

    if (  this.token == other.token  ){
    return true;}
    else return false;
  }

  @override
  int get hashCode {
    int value = 7;
    value = 31 * value + (this.token != null ? this.token.hashCode : 0);
    return value;
  }

  ScriptFunctionCallMintTokenByFixedKeyItem.loadJson(dynamic json) :
    token = TypeTag.fromJson(json['token']) ;

  dynamic toJson() => {
    "token" : token.toJson() ,
    "type" : 9,
    "type_name" : "MintTokenByFixedKey"
  };
}

class ScriptFunctionCallMintTokenByLinearKeyItem extends ScriptFunctionCall {
  TypeTag token;

  ScriptFunctionCallMintTokenByLinearKeyItem(TypeTag token) {
    assert (token != null);
    this.token = token;
  }

  @override
  bool operator ==(covariant ScriptFunctionCallMintTokenByLinearKeyItem other) {
    if (other == null) return false;

    if (  this.token == other.token  ){
    return true;}
    else return false;
  }

  @override
  int get hashCode {
    int value = 7;
    value = 31 * value + (this.token != null ? this.token.hashCode : 0);
    return value;
  }

  ScriptFunctionCallMintTokenByLinearKeyItem.loadJson(dynamic json) :
    token = TypeTag.fromJson(json['token']) ;

  dynamic toJson() => {
    "token" : token.toJson() ,
    "type" : 10,
    "type_name" : "MintTokenByLinearKey"
  };
}

class ScriptFunctionCallPeerToPeerItem extends ScriptFunctionCall {
  TypeTag token_type;
  AccountAddress payee;
  Bytes payee_auth_key;
  Int128 amount;

  ScriptFunctionCallPeerToPeerItem(TypeTag token_type, AccountAddress payee, Bytes payee_auth_key, Int128 amount) {
    assert (token_type != null);
    assert (payee != null);
    assert (payee_auth_key != null);
    assert (amount != null);
    this.token_type = token_type;
    this.payee = payee;
    this.payee_auth_key = payee_auth_key;
    this.amount = amount;
  }

  @override
  bool operator ==(covariant ScriptFunctionCallPeerToPeerItem other) {
    if (other == null) return false;

    if (  this.token_type == other.token_type  &&
      this.payee == other.payee  &&
      this.payee_auth_key == other.payee_auth_key  &&
      this.amount == other.amount  ){
    return true;}
    else return false;
  }

  @override
  int get hashCode {
    int value = 7;
    value = 31 * value + (this.token_type != null ? this.token_type.hashCode : 0);
    value = 31 * value + (this.payee != null ? this.payee.hashCode : 0);
    value = 31 * value + (this.payee_auth_key != null ? this.payee_auth_key.hashCode : 0);
    value = 31 * value + (this.amount != null ? this.amount.hashCode : 0);
    return value;
  }

  ScriptFunctionCallPeerToPeerItem.loadJson(dynamic json) :
    token_type = TypeTag.fromJson(json['token_type']) ,
    payee = AccountAddress.fromJson(json['payee']) ,
    payee_auth_key = Bytes.fromJson(json['payee_auth_key']) ,
    amount = json['amount'] ;

  dynamic toJson() => {
    "token_type" : token_type.toJson() ,
    "payee" : payee.toJson() ,
    "payee_auth_key" : payee_auth_key.toJson() ,
    "amount" : amount ,
    "type" : 11,
    "type_name" : "PeerToPeer"
  };
}

class ScriptFunctionCallPeerToPeerBatchItem extends ScriptFunctionCall {
  TypeTag token_type;
  Bytes payeees;
  Bytes payee_auth_keys;
  Int128 amount;

  ScriptFunctionCallPeerToPeerBatchItem(TypeTag token_type, Bytes payeees, Bytes payee_auth_keys, Int128 amount) {
    assert (token_type != null);
    assert (payeees != null);
    assert (payee_auth_keys != null);
    assert (amount != null);
    this.token_type = token_type;
    this.payeees = payeees;
    this.payee_auth_keys = payee_auth_keys;
    this.amount = amount;
  }

  @override
  bool operator ==(covariant ScriptFunctionCallPeerToPeerBatchItem other) {
    if (other == null) return false;

    if (  this.token_type == other.token_type  &&
      this.payeees == other.payeees  &&
      this.payee_auth_keys == other.payee_auth_keys  &&
      this.amount == other.amount  ){
    return true;}
    else return false;
  }

  @override
  int get hashCode {
    int value = 7;
    value = 31 * value + (this.token_type != null ? this.token_type.hashCode : 0);
    value = 31 * value + (this.payeees != null ? this.payeees.hashCode : 0);
    value = 31 * value + (this.payee_auth_keys != null ? this.payee_auth_keys.hashCode : 0);
    value = 31 * value + (this.amount != null ? this.amount.hashCode : 0);
    return value;
  }

  ScriptFunctionCallPeerToPeerBatchItem.loadJson(dynamic json) :
    token_type = TypeTag.fromJson(json['token_type']) ,
    payeees = Bytes.fromJson(json['payeees']) ,
    payee_auth_keys = Bytes.fromJson(json['payee_auth_keys']) ,
    amount = json['amount'] ;

  dynamic toJson() => {
    "token_type" : token_type.toJson() ,
    "payeees" : payeees.toJson() ,
    "payee_auth_keys" : payee_auth_keys.toJson() ,
    "amount" : amount ,
    "type" : 12,
    "type_name" : "PeerToPeerBatch"
  };
}

class ScriptFunctionCallPeerToPeerWithMetadataItem extends ScriptFunctionCall {
  TypeTag token_type;
  AccountAddress payee;
  Bytes payee_auth_key;
  Int128 amount;
  Bytes metadata;

  ScriptFunctionCallPeerToPeerWithMetadataItem(TypeTag token_type, AccountAddress payee, Bytes payee_auth_key, Int128 amount, Bytes metadata) {
    assert (token_type != null);
    assert (payee != null);
    assert (payee_auth_key != null);
    assert (amount != null);
    assert (metadata != null);
    this.token_type = token_type;
    this.payee = payee;
    this.payee_auth_key = payee_auth_key;
    this.amount = amount;
    this.metadata = metadata;
  }

  @override
  bool operator ==(covariant ScriptFunctionCallPeerToPeerWithMetadataItem other) {
    if (other == null) return false;

    if (  this.token_type == other.token_type  &&
      this.payee == other.payee  &&
      this.payee_auth_key == other.payee_auth_key  &&
      this.amount == other.amount  &&
      this.metadata == other.metadata  ){
    return true;}
    else return false;
  }

  @override
  int get hashCode {
    int value = 7;
    value = 31 * value + (this.token_type != null ? this.token_type.hashCode : 0);
    value = 31 * value + (this.payee != null ? this.payee.hashCode : 0);
    value = 31 * value + (this.payee_auth_key != null ? this.payee_auth_key.hashCode : 0);
    value = 31 * value + (this.amount != null ? this.amount.hashCode : 0);
    value = 31 * value + (this.metadata != null ? this.metadata.hashCode : 0);
    return value;
  }

  ScriptFunctionCallPeerToPeerWithMetadataItem.loadJson(dynamic json) :
    token_type = TypeTag.fromJson(json['token_type']) ,
    payee = AccountAddress.fromJson(json['payee']) ,
    payee_auth_key = Bytes.fromJson(json['payee_auth_key']) ,
    amount = json['amount'] ,
    metadata = Bytes.fromJson(json['metadata']) ;

  dynamic toJson() => {
    "token_type" : token_type.toJson() ,
    "payee" : payee.toJson() ,
    "payee_auth_key" : payee_auth_key.toJson() ,
    "amount" : amount ,
    "metadata" : metadata.toJson() ,
    "type" : 13,
    "type_name" : "PeerToPeerWithMetadata"
  };
}

class ScriptFunctionCallProposeItem extends ScriptFunctionCall {
  TypeTag token_t;
  int voting_delay;
  int voting_period;
  int voting_quorum_rate;
  int min_action_delay;
  int exec_delay;

  ScriptFunctionCallProposeItem(TypeTag token_t, int voting_delay, int voting_period, int voting_quorum_rate, int min_action_delay, int exec_delay) {
    assert (token_t != null);
    assert (voting_delay != null);
    assert (voting_period != null);
    assert (voting_quorum_rate != null);
    assert (min_action_delay != null);
    assert (exec_delay != null);
    this.token_t = token_t;
    this.voting_delay = voting_delay;
    this.voting_period = voting_period;
    this.voting_quorum_rate = voting_quorum_rate;
    this.min_action_delay = min_action_delay;
    this.exec_delay = exec_delay;
  }

  @override
  bool operator ==(covariant ScriptFunctionCallProposeItem other) {
    if (other == null) return false;

    if (  this.token_t == other.token_t  &&
      this.voting_delay == other.voting_delay  &&
      this.voting_period == other.voting_period  &&
      this.voting_quorum_rate == other.voting_quorum_rate  &&
      this.min_action_delay == other.min_action_delay  &&
      this.exec_delay == other.exec_delay  ){
    return true;}
    else return false;
  }

  @override
  int get hashCode {
    int value = 7;
    value = 31 * value + (this.token_t != null ? this.token_t.hashCode : 0);
    value = 31 * value + (this.voting_delay != null ? this.voting_delay.hashCode : 0);
    value = 31 * value + (this.voting_period != null ? this.voting_period.hashCode : 0);
    value = 31 * value + (this.voting_quorum_rate != null ? this.voting_quorum_rate.hashCode : 0);
    value = 31 * value + (this.min_action_delay != null ? this.min_action_delay.hashCode : 0);
    value = 31 * value + (this.exec_delay != null ? this.exec_delay.hashCode : 0);
    return value;
  }

  ScriptFunctionCallProposeItem.loadJson(dynamic json) :
    token_t = TypeTag.fromJson(json['token_t']) ,
    voting_delay = json['voting_delay'] ,
    voting_period = json['voting_period'] ,
    voting_quorum_rate = json['voting_quorum_rate'] ,
    min_action_delay = json['min_action_delay'] ,
    exec_delay = json['exec_delay'] ;

  dynamic toJson() => {
    "token_t" : token_t.toJson() ,
    "voting_delay" : voting_delay ,
    "voting_period" : voting_period ,
    "voting_quorum_rate" : voting_quorum_rate ,
    "min_action_delay" : min_action_delay ,
    "exec_delay" : exec_delay ,
    "type" : 14,
    "type_name" : "Propose"
  };
}

class ScriptFunctionCallProposeModuleUpgradeItem extends ScriptFunctionCall {
  TypeTag token;
  AccountAddress module_address;
  Bytes package_hash;
  int version;
  int exec_delay;

  ScriptFunctionCallProposeModuleUpgradeItem(TypeTag token, AccountAddress module_address, Bytes package_hash, int version, int exec_delay) {
    assert (token != null);
    assert (module_address != null);
    assert (package_hash != null);
    assert (version != null);
    assert (exec_delay != null);
    this.token = token;
    this.module_address = module_address;
    this.package_hash = package_hash;
    this.version = version;
    this.exec_delay = exec_delay;
  }

  @override
  bool operator ==(covariant ScriptFunctionCallProposeModuleUpgradeItem other) {
    if (other == null) return false;

    if (  this.token == other.token  &&
      this.module_address == other.module_address  &&
      this.package_hash == other.package_hash  &&
      this.version == other.version  &&
      this.exec_delay == other.exec_delay  ){
    return true;}
    else return false;
  }

  @override
  int get hashCode {
    int value = 7;
    value = 31 * value + (this.token != null ? this.token.hashCode : 0);
    value = 31 * value + (this.module_address != null ? this.module_address.hashCode : 0);
    value = 31 * value + (this.package_hash != null ? this.package_hash.hashCode : 0);
    value = 31 * value + (this.version != null ? this.version.hashCode : 0);
    value = 31 * value + (this.exec_delay != null ? this.exec_delay.hashCode : 0);
    return value;
  }

  ScriptFunctionCallProposeModuleUpgradeItem.loadJson(dynamic json) :
    token = TypeTag.fromJson(json['token']) ,
    module_address = AccountAddress.fromJson(json['module_address']) ,
    package_hash = Bytes.fromJson(json['package_hash']) ,
    version = json['version'] ,
    exec_delay = json['exec_delay'] ;

  dynamic toJson() => {
    "token" : token.toJson() ,
    "module_address" : module_address.toJson() ,
    "package_hash" : package_hash.toJson() ,
    "version" : version ,
    "exec_delay" : exec_delay ,
    "type" : 15,
    "type_name" : "ProposeModuleUpgrade"
  };
}

class ScriptFunctionCallProposeUpdateConsensusConfigItem extends ScriptFunctionCall {
  int uncle_rate_target;
  int base_block_time_target;
  Int128 base_reward_per_block;
  int base_reward_per_uncle_percent;
  int epoch_block_count;
  int base_block_difficulty_window;
  int min_block_time_target;
  int max_block_time_target;
  int base_max_uncles_per_block;
  int base_block_gas_limit;
  int strategy;
  int exec_delay;

  ScriptFunctionCallProposeUpdateConsensusConfigItem(int uncle_rate_target, int base_block_time_target, Int128 base_reward_per_block, int base_reward_per_uncle_percent, int epoch_block_count, int base_block_difficulty_window, int min_block_time_target, int max_block_time_target, int base_max_uncles_per_block, int base_block_gas_limit, int strategy, int exec_delay) {
    assert (uncle_rate_target != null);
    assert (base_block_time_target != null);
    assert (base_reward_per_block != null);
    assert (base_reward_per_uncle_percent != null);
    assert (epoch_block_count != null);
    assert (base_block_difficulty_window != null);
    assert (min_block_time_target != null);
    assert (max_block_time_target != null);
    assert (base_max_uncles_per_block != null);
    assert (base_block_gas_limit != null);
    assert (strategy != null);
    assert (exec_delay != null);
    this.uncle_rate_target = uncle_rate_target;
    this.base_block_time_target = base_block_time_target;
    this.base_reward_per_block = base_reward_per_block;
    this.base_reward_per_uncle_percent = base_reward_per_uncle_percent;
    this.epoch_block_count = epoch_block_count;
    this.base_block_difficulty_window = base_block_difficulty_window;
    this.min_block_time_target = min_block_time_target;
    this.max_block_time_target = max_block_time_target;
    this.base_max_uncles_per_block = base_max_uncles_per_block;
    this.base_block_gas_limit = base_block_gas_limit;
    this.strategy = strategy;
    this.exec_delay = exec_delay;
  }

  @override
  bool operator ==(covariant ScriptFunctionCallProposeUpdateConsensusConfigItem other) {
    if (other == null) return false;

    if (  this.uncle_rate_target == other.uncle_rate_target  &&
      this.base_block_time_target == other.base_block_time_target  &&
      this.base_reward_per_block == other.base_reward_per_block  &&
      this.base_reward_per_uncle_percent == other.base_reward_per_uncle_percent  &&
      this.epoch_block_count == other.epoch_block_count  &&
      this.base_block_difficulty_window == other.base_block_difficulty_window  &&
      this.min_block_time_target == other.min_block_time_target  &&
      this.max_block_time_target == other.max_block_time_target  &&
      this.base_max_uncles_per_block == other.base_max_uncles_per_block  &&
      this.base_block_gas_limit == other.base_block_gas_limit  &&
      this.strategy == other.strategy  &&
      this.exec_delay == other.exec_delay  ){
    return true;}
    else return false;
  }

  @override
  int get hashCode {
    int value = 7;
    value = 31 * value + (this.uncle_rate_target != null ? this.uncle_rate_target.hashCode : 0);
    value = 31 * value + (this.base_block_time_target != null ? this.base_block_time_target.hashCode : 0);
    value = 31 * value + (this.base_reward_per_block != null ? this.base_reward_per_block.hashCode : 0);
    value = 31 * value + (this.base_reward_per_uncle_percent != null ? this.base_reward_per_uncle_percent.hashCode : 0);
    value = 31 * value + (this.epoch_block_count != null ? this.epoch_block_count.hashCode : 0);
    value = 31 * value + (this.base_block_difficulty_window != null ? this.base_block_difficulty_window.hashCode : 0);
    value = 31 * value + (this.min_block_time_target != null ? this.min_block_time_target.hashCode : 0);
    value = 31 * value + (this.max_block_time_target != null ? this.max_block_time_target.hashCode : 0);
    value = 31 * value + (this.base_max_uncles_per_block != null ? this.base_max_uncles_per_block.hashCode : 0);
    value = 31 * value + (this.base_block_gas_limit != null ? this.base_block_gas_limit.hashCode : 0);
    value = 31 * value + (this.strategy != null ? this.strategy.hashCode : 0);
    value = 31 * value + (this.exec_delay != null ? this.exec_delay.hashCode : 0);
    return value;
  }

  ScriptFunctionCallProposeUpdateConsensusConfigItem.loadJson(dynamic json) :
    uncle_rate_target = json['uncle_rate_target'] ,
    base_block_time_target = json['base_block_time_target'] ,
    base_reward_per_block = json['base_reward_per_block'] ,
    base_reward_per_uncle_percent = json['base_reward_per_uncle_percent'] ,
    epoch_block_count = json['epoch_block_count'] ,
    base_block_difficulty_window = json['base_block_difficulty_window'] ,
    min_block_time_target = json['min_block_time_target'] ,
    max_block_time_target = json['max_block_time_target'] ,
    base_max_uncles_per_block = json['base_max_uncles_per_block'] ,
    base_block_gas_limit = json['base_block_gas_limit'] ,
    strategy = json['strategy'] ,
    exec_delay = json['exec_delay'] ;

  dynamic toJson() => {
    "uncle_rate_target" : uncle_rate_target ,
    "base_block_time_target" : base_block_time_target ,
    "base_reward_per_block" : base_reward_per_block ,
    "base_reward_per_uncle_percent" : base_reward_per_uncle_percent ,
    "epoch_block_count" : epoch_block_count ,
    "base_block_difficulty_window" : base_block_difficulty_window ,
    "min_block_time_target" : min_block_time_target ,
    "max_block_time_target" : max_block_time_target ,
    "base_max_uncles_per_block" : base_max_uncles_per_block ,
    "base_block_gas_limit" : base_block_gas_limit ,
    "strategy" : strategy ,
    "exec_delay" : exec_delay ,
    "type" : 16,
    "type_name" : "ProposeUpdateConsensusConfig"
  };
}

class ScriptFunctionCallProposeUpdateRewardConfigItem extends ScriptFunctionCall {
  int reward_delay;
  int exec_delay;

  ScriptFunctionCallProposeUpdateRewardConfigItem(int reward_delay, int exec_delay) {
    assert (reward_delay != null);
    assert (exec_delay != null);
    this.reward_delay = reward_delay;
    this.exec_delay = exec_delay;
  }

  @override
  bool operator ==(covariant ScriptFunctionCallProposeUpdateRewardConfigItem other) {
    if (other == null) return false;

    if (  this.reward_delay == other.reward_delay  &&
      this.exec_delay == other.exec_delay  ){
    return true;}
    else return false;
  }

  @override
  int get hashCode {
    int value = 7;
    value = 31 * value + (this.reward_delay != null ? this.reward_delay.hashCode : 0);
    value = 31 * value + (this.exec_delay != null ? this.exec_delay.hashCode : 0);
    return value;
  }

  ScriptFunctionCallProposeUpdateRewardConfigItem.loadJson(dynamic json) :
    reward_delay = json['reward_delay'] ,
    exec_delay = json['exec_delay'] ;

  dynamic toJson() => {
    "reward_delay" : reward_delay ,
    "exec_delay" : exec_delay ,
    "type" : 17,
    "type_name" : "ProposeUpdateRewardConfig"
  };
}

class ScriptFunctionCallProposeUpdateTxnPublishOptionItem extends ScriptFunctionCall {
  Bytes script_allow_list;
  bool module_publishing_allowed;
  int exec_delay;

  ScriptFunctionCallProposeUpdateTxnPublishOptionItem(Bytes script_allow_list, bool module_publishing_allowed, int exec_delay) {
    assert (script_allow_list != null);
    assert (module_publishing_allowed != null);
    assert (exec_delay != null);
    this.script_allow_list = script_allow_list;
    this.module_publishing_allowed = module_publishing_allowed;
    this.exec_delay = exec_delay;
  }

  @override
  bool operator ==(covariant ScriptFunctionCallProposeUpdateTxnPublishOptionItem other) {
    if (other == null) return false;

    if (  this.script_allow_list == other.script_allow_list  &&
      this.module_publishing_allowed == other.module_publishing_allowed  &&
      this.exec_delay == other.exec_delay  ){
    return true;}
    else return false;
  }

  @override
  int get hashCode {
    int value = 7;
    value = 31 * value + (this.script_allow_list != null ? this.script_allow_list.hashCode : 0);
    value = 31 * value + (this.module_publishing_allowed != null ? this.module_publishing_allowed.hashCode : 0);
    value = 31 * value + (this.exec_delay != null ? this.exec_delay.hashCode : 0);
    return value;
  }

  ScriptFunctionCallProposeUpdateTxnPublishOptionItem.loadJson(dynamic json) :
    script_allow_list = Bytes.fromJson(json['script_allow_list']) ,
    module_publishing_allowed = json['module_publishing_allowed'] ,
    exec_delay = json['exec_delay'] ;

  dynamic toJson() => {
    "script_allow_list" : script_allow_list.toJson() ,
    "module_publishing_allowed" : module_publishing_allowed ,
    "exec_delay" : exec_delay ,
    "type" : 18,
    "type_name" : "ProposeUpdateTxnPublishOption"
  };
}

class ScriptFunctionCallProposeUpdateTxnTimeoutConfigItem extends ScriptFunctionCall {
  int duration_seconds;
  int exec_delay;

  ScriptFunctionCallProposeUpdateTxnTimeoutConfigItem(int duration_seconds, int exec_delay) {
    assert (duration_seconds != null);
    assert (exec_delay != null);
    this.duration_seconds = duration_seconds;
    this.exec_delay = exec_delay;
  }

  @override
  bool operator ==(covariant ScriptFunctionCallProposeUpdateTxnTimeoutConfigItem other) {
    if (other == null) return false;

    if (  this.duration_seconds == other.duration_seconds  &&
      this.exec_delay == other.exec_delay  ){
    return true;}
    else return false;
  }

  @override
  int get hashCode {
    int value = 7;
    value = 31 * value + (this.duration_seconds != null ? this.duration_seconds.hashCode : 0);
    value = 31 * value + (this.exec_delay != null ? this.exec_delay.hashCode : 0);
    return value;
  }

  ScriptFunctionCallProposeUpdateTxnTimeoutConfigItem.loadJson(dynamic json) :
    duration_seconds = json['duration_seconds'] ,
    exec_delay = json['exec_delay'] ;

  dynamic toJson() => {
    "duration_seconds" : duration_seconds ,
    "exec_delay" : exec_delay ,
    "type" : 19,
    "type_name" : "ProposeUpdateTxnTimeoutConfig"
  };
}

class ScriptFunctionCallProposeUpdateVmConfigItem extends ScriptFunctionCall {
  Bytes instruction_schedule;
  Bytes native_schedule;
  int global_memory_per_byte_cost;
  int global_memory_per_byte_write_cost;
  int min_transaction_gas_units;
  int large_transaction_cutoff;
  int instrinsic_gas_per_byte;
  int maximum_number_of_gas_units;
  int min_price_per_gas_unit;
  int max_price_per_gas_unit;
  int max_transaction_size_in_bytes;
  int gas_unit_scaling_factor;
  int default_account_size;
  int exec_delay;

  ScriptFunctionCallProposeUpdateVmConfigItem(Bytes instruction_schedule, Bytes native_schedule, int global_memory_per_byte_cost, int global_memory_per_byte_write_cost, int min_transaction_gas_units, int large_transaction_cutoff, int instrinsic_gas_per_byte, int maximum_number_of_gas_units, int min_price_per_gas_unit, int max_price_per_gas_unit, int max_transaction_size_in_bytes, int gas_unit_scaling_factor, int default_account_size, int exec_delay) {
    assert (instruction_schedule != null);
    assert (native_schedule != null);
    assert (global_memory_per_byte_cost != null);
    assert (global_memory_per_byte_write_cost != null);
    assert (min_transaction_gas_units != null);
    assert (large_transaction_cutoff != null);
    assert (instrinsic_gas_per_byte != null);
    assert (maximum_number_of_gas_units != null);
    assert (min_price_per_gas_unit != null);
    assert (max_price_per_gas_unit != null);
    assert (max_transaction_size_in_bytes != null);
    assert (gas_unit_scaling_factor != null);
    assert (default_account_size != null);
    assert (exec_delay != null);
    this.instruction_schedule = instruction_schedule;
    this.native_schedule = native_schedule;
    this.global_memory_per_byte_cost = global_memory_per_byte_cost;
    this.global_memory_per_byte_write_cost = global_memory_per_byte_write_cost;
    this.min_transaction_gas_units = min_transaction_gas_units;
    this.large_transaction_cutoff = large_transaction_cutoff;
    this.instrinsic_gas_per_byte = instrinsic_gas_per_byte;
    this.maximum_number_of_gas_units = maximum_number_of_gas_units;
    this.min_price_per_gas_unit = min_price_per_gas_unit;
    this.max_price_per_gas_unit = max_price_per_gas_unit;
    this.max_transaction_size_in_bytes = max_transaction_size_in_bytes;
    this.gas_unit_scaling_factor = gas_unit_scaling_factor;
    this.default_account_size = default_account_size;
    this.exec_delay = exec_delay;
  }

  @override
  bool operator ==(covariant ScriptFunctionCallProposeUpdateVmConfigItem other) {
    if (other == null) return false;

    if (  this.instruction_schedule == other.instruction_schedule  &&
      this.native_schedule == other.native_schedule  &&
      this.global_memory_per_byte_cost == other.global_memory_per_byte_cost  &&
      this.global_memory_per_byte_write_cost == other.global_memory_per_byte_write_cost  &&
      this.min_transaction_gas_units == other.min_transaction_gas_units  &&
      this.large_transaction_cutoff == other.large_transaction_cutoff  &&
      this.instrinsic_gas_per_byte == other.instrinsic_gas_per_byte  &&
      this.maximum_number_of_gas_units == other.maximum_number_of_gas_units  &&
      this.min_price_per_gas_unit == other.min_price_per_gas_unit  &&
      this.max_price_per_gas_unit == other.max_price_per_gas_unit  &&
      this.max_transaction_size_in_bytes == other.max_transaction_size_in_bytes  &&
      this.gas_unit_scaling_factor == other.gas_unit_scaling_factor  &&
      this.default_account_size == other.default_account_size  &&
      this.exec_delay == other.exec_delay  ){
    return true;}
    else return false;
  }

  @override
  int get hashCode {
    int value = 7;
    value = 31 * value + (this.instruction_schedule != null ? this.instruction_schedule.hashCode : 0);
    value = 31 * value + (this.native_schedule != null ? this.native_schedule.hashCode : 0);
    value = 31 * value + (this.global_memory_per_byte_cost != null ? this.global_memory_per_byte_cost.hashCode : 0);
    value = 31 * value + (this.global_memory_per_byte_write_cost != null ? this.global_memory_per_byte_write_cost.hashCode : 0);
    value = 31 * value + (this.min_transaction_gas_units != null ? this.min_transaction_gas_units.hashCode : 0);
    value = 31 * value + (this.large_transaction_cutoff != null ? this.large_transaction_cutoff.hashCode : 0);
    value = 31 * value + (this.instrinsic_gas_per_byte != null ? this.instrinsic_gas_per_byte.hashCode : 0);
    value = 31 * value + (this.maximum_number_of_gas_units != null ? this.maximum_number_of_gas_units.hashCode : 0);
    value = 31 * value + (this.min_price_per_gas_unit != null ? this.min_price_per_gas_unit.hashCode : 0);
    value = 31 * value + (this.max_price_per_gas_unit != null ? this.max_price_per_gas_unit.hashCode : 0);
    value = 31 * value + (this.max_transaction_size_in_bytes != null ? this.max_transaction_size_in_bytes.hashCode : 0);
    value = 31 * value + (this.gas_unit_scaling_factor != null ? this.gas_unit_scaling_factor.hashCode : 0);
    value = 31 * value + (this.default_account_size != null ? this.default_account_size.hashCode : 0);
    value = 31 * value + (this.exec_delay != null ? this.exec_delay.hashCode : 0);
    return value;
  }

  ScriptFunctionCallProposeUpdateVmConfigItem.loadJson(dynamic json) :
    instruction_schedule = Bytes.fromJson(json['instruction_schedule']) ,
    native_schedule = Bytes.fromJson(json['native_schedule']) ,
    global_memory_per_byte_cost = json['global_memory_per_byte_cost'] ,
    global_memory_per_byte_write_cost = json['global_memory_per_byte_write_cost'] ,
    min_transaction_gas_units = json['min_transaction_gas_units'] ,
    large_transaction_cutoff = json['large_transaction_cutoff'] ,
    instrinsic_gas_per_byte = json['instrinsic_gas_per_byte'] ,
    maximum_number_of_gas_units = json['maximum_number_of_gas_units'] ,
    min_price_per_gas_unit = json['min_price_per_gas_unit'] ,
    max_price_per_gas_unit = json['max_price_per_gas_unit'] ,
    max_transaction_size_in_bytes = json['max_transaction_size_in_bytes'] ,
    gas_unit_scaling_factor = json['gas_unit_scaling_factor'] ,
    default_account_size = json['default_account_size'] ,
    exec_delay = json['exec_delay'] ;

  dynamic toJson() => {
    "instruction_schedule" : instruction_schedule.toJson() ,
    "native_schedule" : native_schedule.toJson() ,
    "global_memory_per_byte_cost" : global_memory_per_byte_cost ,
    "global_memory_per_byte_write_cost" : global_memory_per_byte_write_cost ,
    "min_transaction_gas_units" : min_transaction_gas_units ,
    "large_transaction_cutoff" : large_transaction_cutoff ,
    "instrinsic_gas_per_byte" : instrinsic_gas_per_byte ,
    "maximum_number_of_gas_units" : maximum_number_of_gas_units ,
    "min_price_per_gas_unit" : min_price_per_gas_unit ,
    "max_price_per_gas_unit" : max_price_per_gas_unit ,
    "max_transaction_size_in_bytes" : max_transaction_size_in_bytes ,
    "gas_unit_scaling_factor" : gas_unit_scaling_factor ,
    "default_account_size" : default_account_size ,
    "exec_delay" : exec_delay ,
    "type" : 20,
    "type_name" : "ProposeUpdateVmConfig"
  };
}

class ScriptFunctionCallPublishItem extends ScriptFunctionCall {
  Bytes key;

  ScriptFunctionCallPublishItem(Bytes key) {
    assert (key != null);
    this.key = key;
  }

  @override
  bool operator ==(covariant ScriptFunctionCallPublishItem other) {
    if (other == null) return false;

    if (  this.key == other.key  ){
    return true;}
    else return false;
  }

  @override
  int get hashCode {
    int value = 7;
    value = 31 * value + (this.key != null ? this.key.hashCode : 0);
    return value;
  }

  ScriptFunctionCallPublishItem.loadJson(dynamic json) :
    key = Bytes.fromJson(json['key']) ;

  dynamic toJson() => {
    "key" : key.toJson() ,
    "type" : 21,
    "type_name" : "Publish"
  };
}

class ScriptFunctionCallQueueProposalActionItem extends ScriptFunctionCall {
  TypeTag token_t;
  TypeTag action_t;
  AccountAddress proposer_address;
  int proposal_id;

  ScriptFunctionCallQueueProposalActionItem(TypeTag token_t, TypeTag action_t, AccountAddress proposer_address, int proposal_id) {
    assert (token_t != null);
    assert (action_t != null);
    assert (proposer_address != null);
    assert (proposal_id != null);
    this.token_t = token_t;
    this.action_t = action_t;
    this.proposer_address = proposer_address;
    this.proposal_id = proposal_id;
  }

  @override
  bool operator ==(covariant ScriptFunctionCallQueueProposalActionItem other) {
    if (other == null) return false;

    if (  this.token_t == other.token_t  &&
      this.action_t == other.action_t  &&
      this.proposer_address == other.proposer_address  &&
      this.proposal_id == other.proposal_id  ){
    return true;}
    else return false;
  }

  @override
  int get hashCode {
    int value = 7;
    value = 31 * value + (this.token_t != null ? this.token_t.hashCode : 0);
    value = 31 * value + (this.action_t != null ? this.action_t.hashCode : 0);
    value = 31 * value + (this.proposer_address != null ? this.proposer_address.hashCode : 0);
    value = 31 * value + (this.proposal_id != null ? this.proposal_id.hashCode : 0);
    return value;
  }

  ScriptFunctionCallQueueProposalActionItem.loadJson(dynamic json) :
    token_t = TypeTag.fromJson(json['token_t']) ,
    action_t = TypeTag.fromJson(json['action_t']) ,
    proposer_address = AccountAddress.fromJson(json['proposer_address']) ,
    proposal_id = json['proposal_id'] ;

  dynamic toJson() => {
    "token_t" : token_t.toJson() ,
    "action_t" : action_t.toJson() ,
    "proposer_address" : proposer_address.toJson() ,
    "proposal_id" : proposal_id ,
    "type" : 22,
    "type_name" : "QueueProposalAction"
  };
}

class ScriptFunctionCallRevokeVoteItem extends ScriptFunctionCall {
  TypeTag token;
  TypeTag action;
  AccountAddress proposer_address;
  int proposal_id;

  ScriptFunctionCallRevokeVoteItem(TypeTag token, TypeTag action, AccountAddress proposer_address, int proposal_id) {
    assert (token != null);
    assert (action != null);
    assert (proposer_address != null);
    assert (proposal_id != null);
    this.token = token;
    this.action = action;
    this.proposer_address = proposer_address;
    this.proposal_id = proposal_id;
  }

  @override
  bool operator ==(covariant ScriptFunctionCallRevokeVoteItem other) {
    if (other == null) return false;

    if (  this.token == other.token  &&
      this.action == other.action  &&
      this.proposer_address == other.proposer_address  &&
      this.proposal_id == other.proposal_id  ){
    return true;}
    else return false;
  }

  @override
  int get hashCode {
    int value = 7;
    value = 31 * value + (this.token != null ? this.token.hashCode : 0);
    value = 31 * value + (this.action != null ? this.action.hashCode : 0);
    value = 31 * value + (this.proposer_address != null ? this.proposer_address.hashCode : 0);
    value = 31 * value + (this.proposal_id != null ? this.proposal_id.hashCode : 0);
    return value;
  }

  ScriptFunctionCallRevokeVoteItem.loadJson(dynamic json) :
    token = TypeTag.fromJson(json['token']) ,
    action = TypeTag.fromJson(json['action']) ,
    proposer_address = AccountAddress.fromJson(json['proposer_address']) ,
    proposal_id = json['proposal_id'] ;

  dynamic toJson() => {
    "token" : token.toJson() ,
    "action" : action.toJson() ,
    "proposer_address" : proposer_address.toJson() ,
    "proposal_id" : proposal_id ,
    "type" : 23,
    "type_name" : "RevokeVote"
  };
}

class ScriptFunctionCallRotateAuthenticationKeyItem extends ScriptFunctionCall {
  Bytes new_key;

  ScriptFunctionCallRotateAuthenticationKeyItem(Bytes new_key) {
    assert (new_key != null);
    this.new_key = new_key;
  }

  @override
  bool operator ==(covariant ScriptFunctionCallRotateAuthenticationKeyItem other) {
    if (other == null) return false;

    if (  this.new_key == other.new_key  ){
    return true;}
    else return false;
  }

  @override
  int get hashCode {
    int value = 7;
    value = 31 * value + (this.new_key != null ? this.new_key.hashCode : 0);
    return value;
  }

  ScriptFunctionCallRotateAuthenticationKeyItem.loadJson(dynamic json) :
    new_key = Bytes.fromJson(json['new_key']) ;

  dynamic toJson() => {
    "new_key" : new_key.toJson() ,
    "type" : 24,
    "type_name" : "RotateAuthenticationKey"
  };
}

class ScriptFunctionCallSplitFixedKeyItem extends ScriptFunctionCall {
  TypeTag token;
  AccountAddress for_address;
  Int128 amount;
  int lock_period;

  ScriptFunctionCallSplitFixedKeyItem(TypeTag token, AccountAddress for_address, Int128 amount, int lock_period) {
    assert (token != null);
    assert (for_address != null);
    assert (amount != null);
    assert (lock_period != null);
    this.token = token;
    this.for_address = for_address;
    this.amount = amount;
    this.lock_period = lock_period;
  }

  @override
  bool operator ==(covariant ScriptFunctionCallSplitFixedKeyItem other) {
    if (other == null) return false;

    if (  this.token == other.token  &&
      this.for_address == other.for_address  &&
      this.amount == other.amount  &&
      this.lock_period == other.lock_period  ){
    return true;}
    else return false;
  }

  @override
  int get hashCode {
    int value = 7;
    value = 31 * value + (this.token != null ? this.token.hashCode : 0);
    value = 31 * value + (this.for_address != null ? this.for_address.hashCode : 0);
    value = 31 * value + (this.amount != null ? this.amount.hashCode : 0);
    value = 31 * value + (this.lock_period != null ? this.lock_period.hashCode : 0);
    return value;
  }

  ScriptFunctionCallSplitFixedKeyItem.loadJson(dynamic json) :
    token = TypeTag.fromJson(json['token']) ,
    for_address = AccountAddress.fromJson(json['for_address']) ,
    amount = json['amount'] ,
    lock_period = json['lock_period'] ;

  dynamic toJson() => {
    "token" : token.toJson() ,
    "for_address" : for_address.toJson() ,
    "amount" : amount ,
    "lock_period" : lock_period ,
    "type" : 25,
    "type_name" : "SplitFixedKey"
  };
}

class ScriptFunctionCallSubmitModuleUpgradePlanItem extends ScriptFunctionCall {
  TypeTag token;
  AccountAddress proposer_address;
  int proposal_id;

  ScriptFunctionCallSubmitModuleUpgradePlanItem(TypeTag token, AccountAddress proposer_address, int proposal_id) {
    assert (token != null);
    assert (proposer_address != null);
    assert (proposal_id != null);
    this.token = token;
    this.proposer_address = proposer_address;
    this.proposal_id = proposal_id;
  }

  @override
  bool operator ==(covariant ScriptFunctionCallSubmitModuleUpgradePlanItem other) {
    if (other == null) return false;

    if (  this.token == other.token  &&
      this.proposer_address == other.proposer_address  &&
      this.proposal_id == other.proposal_id  ){
    return true;}
    else return false;
  }

  @override
  int get hashCode {
    int value = 7;
    value = 31 * value + (this.token != null ? this.token.hashCode : 0);
    value = 31 * value + (this.proposer_address != null ? this.proposer_address.hashCode : 0);
    value = 31 * value + (this.proposal_id != null ? this.proposal_id.hashCode : 0);
    return value;
  }

  ScriptFunctionCallSubmitModuleUpgradePlanItem.loadJson(dynamic json) :
    token = TypeTag.fromJson(json['token']) ,
    proposer_address = AccountAddress.fromJson(json['proposer_address']) ,
    proposal_id = json['proposal_id'] ;

  dynamic toJson() => {
    "token" : token.toJson() ,
    "proposer_address" : proposer_address.toJson() ,
    "proposal_id" : proposal_id ,
    "type" : 26,
    "type_name" : "SubmitModuleUpgradePlan"
  };
}

class ScriptFunctionCallTakeOfferItem extends ScriptFunctionCall {
  TypeTag offered;
  AccountAddress offer_address;

  ScriptFunctionCallTakeOfferItem(TypeTag offered, AccountAddress offer_address) {
    assert (offered != null);
    assert (offer_address != null);
    this.offered = offered;
    this.offer_address = offer_address;
  }

  @override
  bool operator ==(covariant ScriptFunctionCallTakeOfferItem other) {
    if (other == null) return false;

    if (  this.offered == other.offered  &&
      this.offer_address == other.offer_address  ){
    return true;}
    else return false;
  }

  @override
  int get hashCode {
    int value = 7;
    value = 31 * value + (this.offered != null ? this.offered.hashCode : 0);
    value = 31 * value + (this.offer_address != null ? this.offer_address.hashCode : 0);
    return value;
  }

  ScriptFunctionCallTakeOfferItem.loadJson(dynamic json) :
    offered = TypeTag.fromJson(json['offered']) ,
    offer_address = AccountAddress.fromJson(json['offer_address']) ;

  dynamic toJson() => {
    "offered" : offered.toJson() ,
    "offer_address" : offer_address.toJson() ,
    "type" : 27,
    "type_name" : "TakeOffer"
  };
}

class ScriptFunctionCallUnstakeVoteItem extends ScriptFunctionCall {
  TypeTag token;
  TypeTag action;
  AccountAddress proposer_address;
  int proposal_id;

  ScriptFunctionCallUnstakeVoteItem(TypeTag token, TypeTag action, AccountAddress proposer_address, int proposal_id) {
    assert (token != null);
    assert (action != null);
    assert (proposer_address != null);
    assert (proposal_id != null);
    this.token = token;
    this.action = action;
    this.proposer_address = proposer_address;
    this.proposal_id = proposal_id;
  }

  @override
  bool operator ==(covariant ScriptFunctionCallUnstakeVoteItem other) {
    if (other == null) return false;

    if (  this.token == other.token  &&
      this.action == other.action  &&
      this.proposer_address == other.proposer_address  &&
      this.proposal_id == other.proposal_id  ){
    return true;}
    else return false;
  }

  @override
  int get hashCode {
    int value = 7;
    value = 31 * value + (this.token != null ? this.token.hashCode : 0);
    value = 31 * value + (this.action != null ? this.action.hashCode : 0);
    value = 31 * value + (this.proposer_address != null ? this.proposer_address.hashCode : 0);
    value = 31 * value + (this.proposal_id != null ? this.proposal_id.hashCode : 0);
    return value;
  }

  ScriptFunctionCallUnstakeVoteItem.loadJson(dynamic json) :
    token = TypeTag.fromJson(json['token']) ,
    action = TypeTag.fromJson(json['action']) ,
    proposer_address = AccountAddress.fromJson(json['proposer_address']) ,
    proposal_id = json['proposal_id'] ;

  dynamic toJson() => {
    "token" : token.toJson() ,
    "action" : action.toJson() ,
    "proposer_address" : proposer_address.toJson() ,
    "proposal_id" : proposal_id ,
    "type" : 28,
    "type_name" : "UnstakeVote"
  };
}

class ScriptFunctionCallUpdateModuleUpgradeStrategyItem extends ScriptFunctionCall {
  int strategy;

  ScriptFunctionCallUpdateModuleUpgradeStrategyItem(int strategy) {
    assert (strategy != null);
    this.strategy = strategy;
  }

  @override
  bool operator ==(covariant ScriptFunctionCallUpdateModuleUpgradeStrategyItem other) {
    if (other == null) return false;

    if (  this.strategy == other.strategy  ){
    return true;}
    else return false;
  }

  @override
  int get hashCode {
    int value = 7;
    value = 31 * value + (this.strategy != null ? this.strategy.hashCode : 0);
    return value;
  }

  ScriptFunctionCallUpdateModuleUpgradeStrategyItem.loadJson(dynamic json) :
    strategy = json['strategy'] ;

  dynamic toJson() => {
    "strategy" : strategy ,
    "type" : 29,
    "type_name" : "UpdateModuleUpgradeStrategy"
  };
}
