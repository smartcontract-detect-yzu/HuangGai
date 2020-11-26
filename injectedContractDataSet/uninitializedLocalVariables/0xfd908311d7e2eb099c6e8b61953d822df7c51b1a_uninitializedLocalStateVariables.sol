/**
 *Submitted for verification at Etherscan.io on 2020-10-02
*/

/**
 *Submitted for verification at Etherscan.io on 2020-09-14
*/

pragma solidity 0.6.4;
library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     *
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c ;	//inject UNINIT LOCAL/STATE VAR

        require(c >= a, "SafeMath: addition overflow");

        return c;
    }
 
    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return sub(a, b, "SafeMath: subtraction overflow");
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        uint256 c ;	//inject UNINIT LOCAL/STATE VAR


        return c;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     *
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
        if (a == 0) {
            return 0;
        }

        uint256 c ;	//inject UNINIT LOCAL/STATE VAR

        require(c / a == b, "SafeMath: multiplication overflow");

        return c;
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return div(a, b, "SafeMath: division by zero");
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b > 0, errorMessage);
        uint256 c ;	//inject UNINIT LOCAL/STATE VAR

        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return mod(a, b, "SafeMath: modulo by zero");
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts with custom message when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b != 0, errorMessage);
        return a % b;
    }
}

//ERC20 Interface
interface ERC20 {
    function totalSupply() external view returns (uint);
    function balanceOf(address account) external view returns (uint);
    function transfer(address, uint) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint);
    function approve(address, uint) external returns (bool);
    function transferFrom(address, address, uint) external returns (bool);
    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value);
    }
    
interface ASP {
    
   function scaledToken(uint amount) external returns(bool);
   function totalFrozen() external view returns (uint256);
 }

interface OSP {
    
   function scaledToken(uint amount) external returns(bool);
   function totalFrozen() external view returns (uint256);
 }
 
interface DSP {
    
   function scaledToken(uint amount) external returns(bool);
   function totalFrozen() external view returns (uint256);
 }

interface USP {
    
   function scaledToken(uint amount) external returns(bool);
   function totalFrozen() external view returns (uint256);
 }
    
//======================================AXIA CONTRACT=========================================//
contract AXIATOKEN is ERC20 {
    
    using SafeMath for uint256;
    
//======================================AXIA EVENTS=========================================//

    event NewEpoch(uint epoch, uint emission, uint nextepoch);
    event NewDay(uint epoch, uint day, uint nextday);
    event BurnEvent(address indexed pool, address indexed burnaddress, uint amount);
    event emissions(address indexed root, address indexed pool, uint value);
    event TrigRewardEvent(address indexed root, address indexed receiver, uint value);
    event BasisPointAdded(uint value);
    
    
   // ERC-20 Parameters
    string public name; 
    string public symbol;
    uint public decimals; 
    uint public startdecimal;
    uint public override totalSupply;
    uint public initialsupply;
    
     //======================================STAKING POOLS=========================================//
    
    address public lonePool;
    address public swapPool;
    address public DefiPool;
    address public OraclePool;
    
    address public burningPool;
    
    uint public pool1Amount;
    uint public pool2Amount;
    uint public pool3Amount;
    uint public pool4Amount;
    uint public poolAmountTrig;
    
    
    uint public TrigAmount;
    
    
    // ERC-20 Mappings
    mapping(address => uint) public override balanceOf;
    mapping(address => mapping(address => uint)) public override allowance;
    
    
    // Public Parameters
    uint crypto; 
    uint startcrypto;
    uint public emission;
    uint public currentEpoch; 
    uint public currentDay;
    uint public daysPerEpoch; 
    uint public secondsPerDay;
    uint public genesis;
    uint public nextEpochTime; 
    uint public nextDayTime;
    uint public amountToEmit;
    uint public BPE;
    
    //======================================BASIS POINT VARIABLES=========================================//
    uint public bpValue;
    uint public actualValue;
    uint public TrigReward;
    uint public burnAmount;
    address administrator;
    uint totalEmitted;
    
    uint256 public pool1percentage ;	//inject UNINIT LOCAL/STATE VAR

    uint256 public pool2percentage ;	//inject UNINIT LOCAL/STATE VAR

    uint256 public pool3percentage ;	//inject UNINIT LOCAL/STATE VAR

    uint256 public pool4percentage ;	//inject UNINIT LOCAL/STATE VAR

    uint256 public trigRewardpercentage ;	//inject UNINIT LOCAL/STATE VAR

    
    
    address public messagesender;
     
    // Public Mappings
    mapping(address=>bool) public Address_Whitelisted;
    mapping(address=>bool) public emission_Whitelisted;
    

    //=====================================CREATION=========================================//
    // Constructor
    constructor() public {
        name = "AXIA TOKEN (axiaprotocol.io)"; 
        symbol = "AXIA-V3"; 
        decimals = 18; 
        startdecimal = 16;
        crypto = 1*10**decimals; 
        startcrypto =  1*10**startdecimal; 
        totalSupply = 3229600*crypto;                                 
        initialsupply = 62960000*startcrypto;
        emission = 7200*crypto; 
        currentEpoch = 1; 
        currentDay = 1;                             
        genesis = now;
        
        daysPerEpoch = 180; 
        secondsPerDay = 86400; 
       
        administrator = msg.sender;
        balanceOf[administrator] = initialsupply; 
        emit Transfer(administrator, address(this), initialsupply);                                
        nextEpochTime = genesis + (secondsPerDay * daysPerEpoch);                                   
        nextDayTime = genesis + secondsPerDay;                                                      
        
        Address_Whitelisted[administrator] = true; 
        emission_Whitelisted[administrator] = true;
        
        
        
    }
    
//========================================CONFIGURATIONS=========================================//
    
    function poolconfigs(address _axia, address _swap, address _defi, address _oracle) public onlyAdministrator returns (bool success) {
        
        lonePool = _axia;
        swapPool = _swap;
        DefiPool = _defi;
        OraclePool = _oracle;
        
        
        
        return true;
    }
    
    function burningPoolconfigs(address _pooladdress) public onlyAdministrator returns (bool success) {
           
        burningPool = _pooladdress;
        
        return true;
    }
    
    
    modifier onlyAdministrator() {
        require(msg.sender == administrator, "Ownable: caller is not the owner");
        _;
    }
    
    modifier onlyBurningPool() {
        require(msg.sender == burningPool, "Authorization: Only the pool that allows burn can call on this");
        _;
    }
    
    function whitelist(address _address) public onlyAdministrator returns (bool success) {
       Address_Whitelisted[_address] = true;
        return true;
    }
    
    function unwhitelist(address _address) public onlyAdministrator returns (bool success) {
       Address_Whitelisted[_address] = false;
        return true;
    }
    
    function secondAndDay(uint _secondsperday, uint _daysperepoch) public onlyAdministrator returns (bool success) {
       secondsPerDay = _secondsperday;
       daysPerEpoch = _daysperepoch;
        return true;
    }
    
    function nextEpoch(uint _nextepoch) public onlyAdministrator returns (bool success) {
       nextEpochTime = _nextepoch;
       
        return true;
    }
    
    function whitelistOnEmission(address _address) public onlyAdministrator returns (bool success) {
       emission_Whitelisted[_address] = true;
        return true;
    }
    
    function unwhitelistOnEmission(address _address) public onlyAdministrator returns (bool success) {
       emission_Whitelisted[_address] = false;
        return true;
    }
    
    function poolpercentages(uint _p1, uint _p2, uint _p3, uint _p4, uint trigRe) public onlyAdministrator returns (bool success) {
       
       pool1percentage = _p1;
       pool2percentage = _p2;
       pool3percentage = _p3;
       pool4percentage = _p4;
       trigRewardpercentage = trigRe;
       
       return true;
    }
    
    function Burn(uint _amount) public returns (bool success) {
       
       require(balanceOf[msg.sender] >= _amount, "You do not have the amount of tokens you wanna burn in your wallet");
       balanceOf[msg.sender] -= _amount;
       totalSupply -= _amount;
       emit BurnEvent(msg.sender, address(0x0), _amount);
       return true;
       
    }
    
   //========================================ERC20=========================================//
    // ERC20 Transfer function
    function transfer(address to, uint value) public override returns (bool success) {
        _transfer(msg.sender, to, value);
        return true;
    }
    // ERC20 Approve function
    function approve(address spender, uint value) public override returns (bool success) {
        allowance[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }
    // ERC20 TransferFrom function
    function transferFrom(address from, address to, uint value) public override returns (bool success) {
        require(value <= allowance[from][msg.sender], 'Must not send more than allowance');
        allowance[from][msg.sender] -= value;
        _transfer(from, to, value);
        return true;
    }
    
  
    
    // Internal transfer function which includes the Fee
    function _transfer(address _from, address _to, uint _value) private {
        
        messagesender = msg.sender; //this is the person actually making the call on this function
        
        
        require(balanceOf[_from] >= _value, 'Must not send more than balance');
        require(balanceOf[_to] + _value >= balanceOf[_to], 'Balance overflow');
        
        balanceOf[_from] -= _value;
        if(Address_Whitelisted[msg.sender]){ //if the person making the transaction is whitelisted, the no burn on the transaction
        
          actualValue = _value;
          
        }else{
         
        bpValue = mulDiv(_value, 15, 10000); //this is 0.15% for basis point
        actualValue = _value - bpValue; //this is the amount to be sent
        
        balanceOf[address(this)] += bpValue; //this is adding the basis point charged to this contract
        emit Transfer(_from, address(this), bpValue);
        
        BPE += bpValue; //this is increasing the virtual basis point amount
        emit BasisPointAdded(bpValue); 
        
        
        }
        
        if(emission_Whitelisted[messagesender] == false){ //this is so that staking and unstaking will not trigger the emission
          
                if(now >= nextDayTime){
                
                amountToEmit = emittingAmount();
                
                pool1Amount = mulDiv(amountToEmit, pool1percentage, 10000);
                pool2Amount = mulDiv(amountToEmit, pool2percentage, 10000);
                pool3Amount = mulDiv(amountToEmit, pool3percentage, 10000);
                pool4Amount = mulDiv(amountToEmit, pool4percentage, 10000);
                
                
                poolAmountTrig = mulDiv(amountToEmit, trigRewardpercentage, 10000);
                TrigAmount = poolAmountTrig.div(2);
                
                pool1Amount = pool1Amount.sub(TrigAmount);
                pool2Amount = pool2Amount.sub(TrigAmount);
                
                TrigReward = poolAmountTrig;
                
                uint Ofrozenamount ;	//inject UNINIT LOCAL/STATE VAR

                uint Dfrozenamount ;	//inject UNINIT LOCAL/STATE VAR

                uint Ufrozenamount ;	//inject UNINIT LOCAL/STATE VAR

                uint Afrozenamount ;	//inject UNINIT LOCAL/STATE VAR

                
                if(Ofrozenamount > 0){
                    
                OSP(OraclePool).scaledToken(pool4Amount);
                balanceOf[OraclePool] += pool4Amount;
                emit Transfer(address(this), OraclePool, pool4Amount);
                
                
                    
                }else{
                  
                 balanceOf[address(this)] += pool4Amount; 
                 emit Transfer(address(this), address(this), pool4Amount);
                 
                 BPE += pool4Amount;
                    
                }
                
                if(Dfrozenamount > 0){
                    
                DSP(DefiPool).scaledToken(pool3Amount);
                balanceOf[DefiPool] += pool3Amount;
                emit Transfer(address(this), DefiPool, pool3Amount);
                
                
                    
                }else{
                  
                 balanceOf[address(this)] += pool3Amount; 
                 emit Transfer(address(this), address(this), pool3Amount);
                 BPE += pool3Amount;
                    
                }
                
                if(Ufrozenamount > 0){
                    
                USP(swapPool).scaledToken(pool2Amount);
                balanceOf[swapPool] += pool2Amount;
                emit Transfer(address(this), swapPool, pool2Amount);
                
                    
                }else{
                  
                 balanceOf[address(this)] += pool2Amount; 
                 emit Transfer(address(this), address(this), pool2Amount);
                 BPE += pool2Amount;
                    
                }
                
                if(Afrozenamount > 0){
                    
                 ASP(lonePool).scaledToken(pool1Amount);
                 balanceOf[lonePool] += pool1Amount;
                 emit Transfer(address(this), lonePool, pool1Amount);
                
                }else{
                  
                 balanceOf[address(this)] += pool1Amount; 
                 emit Transfer(address(this), address(this), pool1Amount);
                 BPE += pool1Amount;
                    
                }
                
                nextDayTime += secondsPerDay;
                currentDay += 1; 
                emit NewDay(currentEpoch, currentDay, nextDayTime);
                
                //reward the wallet that triggered the EMISSION
                balanceOf[_from] += TrigReward; //this is rewardig the person that triggered the emission
                emit Transfer(address(this), _from, TrigReward);
                emit TrigRewardEvent(address(this), msg.sender, TrigReward);
                
            }
        
            
        }
       
       balanceOf[_to] += actualValue;
       emit Transfer(_from, _to, actualValue);
    }
    
    

    
   
    //======================================EMISSION========================================//
    // Internal - Update emission function
    
    function emittingAmount() internal returns(uint){
       
        if(now >= nextEpochTime){
            
            currentEpoch += 1;
            
            //if it is greater than the nextEpochTime, then it means we have entered the new epoch, 
            //thats why we are adding 1 to it, meaning new epoch emission
            
            if(currentEpoch > 10){
            
               emission = BPE;
               BPE -= emission.div(2);
               balanceOf[address(this)] -= emission.div(2);
            
               
            }
            emission = emission/2;
            nextEpochTime += (secondsPerDay * daysPerEpoch);
            emit NewEpoch(currentEpoch, emission, nextEpochTime);
          
        }
        
        return emission;
        
        
    }
  
  
  
    function ospfrozen() public view returns(uint){
        
        return OSP(OraclePool).totalFrozen();
       
    }
    
    function dspfrozen() public view returns(uint){
        
        return DSP(DefiPool).totalFrozen();
       
    }
    
    function uspfrozen() public view returns(uint){
        
        return USP(swapPool).totalFrozen();
       
    } 
    
    function aspfrozen() public view returns(uint){
        
        return ASP(lonePool).totalFrozen();
       
    }
    
     function mulDiv (uint x, uint y, uint z) public pure returns (uint) {
          (uint l, uint h) = fullMul (x, y);
          assert (h < z);
          uint mm ;	//inject UNINIT LOCAL/STATE VAR

          if (mm > l) h -= 1;
          l -= mm;
          uint pow2 ;	//inject UNINIT LOCAL/STATE VAR

          z /= pow2;
          l /= pow2;
          l += h * ((-pow2) / pow2 + 1);
          uint r ;	//inject UNINIT LOCAL/STATE VAR

          r *= 2 - z * r;
          r *= 2 - z * r;
          r *= 2 - z * r;
          r *= 2 - z * r;
          r *= 2 - z * r;
          r *= 2 - z * r;
          r *= 2 - z * r;
          r *= 2 - z * r;
          return l * r;
    }
    
     function fullMul (uint x, uint y) private pure returns (uint l, uint h) {
          uint mm ;	//inject UNINIT LOCAL/STATE VAR

          l = x * y;
          h = mm - l;
          if (mm < l) h -= 1;
    }
    
   
}