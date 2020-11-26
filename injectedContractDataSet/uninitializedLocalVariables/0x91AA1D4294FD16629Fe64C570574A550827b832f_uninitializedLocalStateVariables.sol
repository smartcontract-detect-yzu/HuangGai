/**
 *Submitted for verification at Etherscan.io on 2020-10-22
*/

/*
https://powerpool.finance/

          wrrrw r wrr
         ppwr rrr wppr0       prwwwrp                                 prwwwrp                   wr0
        rr 0rrrwrrprpwp0      pp   pr  prrrr0 pp   0r  prrrr0  0rwrrr pp   pr  prrrr0  prrrr0    r0
        rrp pr   wr00rrp      prwww0  pp   wr pp w00r prwwwpr  0rw    prwww0  pp   wr pp   wr    r0
        r0rprprwrrrp pr0      pp      wr   pr pp rwwr wr       0r     pp      wr   pr wr   pr    r0
         prwr wrr0wpwr        00        www0   0w0ww    www0   0w     00        www0    www0   0www0
          wrr ww0rrrr

*/

// File: contracts/interfaces/BPoolInterface.sol

pragma solidity 0.6.12;

abstract contract BPoolInterface {
    function approve(address spender, uint256 amount) external virtual returns (bool);
    function transfer(address recipient, uint256 amount) external virtual returns (bool);
    function transferFrom(address spender, address recipient, uint256 amount) external virtual returns (bool);

    function joinPool(uint poolAmountOut, uint[] calldata maxAmountsIn) external virtual;
    function exitPool(uint poolAmountIn, uint[] calldata minAmountsOut) external virtual;
    function swapExactAmountIn(address, uint, address, uint, uint) external virtual returns (uint, uint);
    function swapExactAmountOut(address, uint, address, uint, uint) external virtual returns (uint, uint);
    function calcInGivenOut(uint, uint, uint, uint, uint, uint) public pure virtual returns (uint);
    function getDenormalizedWeight(address) external view virtual returns (uint);
    function getBalance(address) external view virtual returns (uint);
    function getSwapFee() external view virtual returns (uint);
    function totalSupply() external view virtual returns (uint);
    function balanceOf(address) external view virtual returns (uint);
    function getTotalDenormalizedWeight() external view virtual returns (uint);

    function getCommunityFee() external view virtual returns (uint, uint, uint, address);
    function calcAmountWithCommunityFee(uint, uint, address) external view virtual returns (uint, uint);
    function getRestrictions() external view virtual returns (address);

    function getCurrentTokens() external view virtual returns (address[] memory tokens);
}

// File: @openzeppelin/contracts/token/ERC20/IERC20.sol

// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

/**
 * @dev Interface of the ERC20 standard as defined in the EIP.
 */
interface IERC20 {
    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `recipient`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `sender` to `recipient` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

// File: contracts/interfaces/TokenInterface.sol

pragma solidity 0.6.12;


abstract contract TokenInterface is IERC20 {
    function deposit() public virtual payable;
    function withdraw(uint) public virtual;
}

// File: contracts/IPoolRestrictions.sol

pragma solidity 0.6.12;


interface IPoolRestrictions {
    function getMaxTotalSupply(address _pool) external virtual view returns(uint256);
    function isVotingSignatureAllowed(address _votingAddress, bytes4 _signature) external virtual view returns(bool);
    function isWithoutFee(address _addr) external virtual view returns(bool);
}

// File: contracts/uniswapv2/interfaces/IUniswapV2Pair.sol

pragma solidity >=0.5.0;

interface IUniswapV2Pair {
    event Approval(address indexed owner, address indexed spender, uint value);
    event Transfer(address indexed from, address indexed to, uint value);

    function name() external pure returns (string memory);
    function symbol() external pure returns (string memory);
    function decimals() external pure returns (uint8);
    function totalSupply() external view returns (uint);
    function balanceOf(address owner) external view returns (uint);
    function allowance(address owner, address spender) external view returns (uint);

    function approve(address spender, uint value) external returns (bool);
    function transfer(address to, uint value) external returns (bool);
    function transferFrom(address from, address to, uint value) external returns (bool);

    function DOMAIN_SEPARATOR() external view returns (bytes32);
    function PERMIT_TYPEHASH() external pure returns (bytes32);
    function nonces(address owner) external view returns (uint);

    function permit(address owner, address spender, uint value, uint deadline, uint8 v, bytes32 r, bytes32 s) external;

    event Mint(address indexed sender, uint amount0, uint amount1);
    event Burn(address indexed sender, uint amount0, uint amount1, address indexed to);
    event Swap(
        address indexed sender,
        uint amount0In,
        uint amount1In,
        uint amount0Out,
        uint amount1Out,
        address indexed to
    );
    event Sync(uint112 reserve0, uint112 reserve1);

    function MINIMUM_LIQUIDITY() external pure returns (uint);
    function factory() external view returns (address);
    function token0() external view returns (address);
    function token1() external view returns (address);
    function getReserves() external view returns (uint112 reserve0, uint112 reserve1, uint32 blockTimestampLast);
    function price0CumulativeLast() external view returns (uint);
    function price1CumulativeLast() external view returns (uint);
    function kLast() external view returns (uint);

    function mint(address to) external returns (uint liquidity);
    function burn(address to) external returns (uint amount0, uint amount1);
    function swap(uint amount0Out, uint amount1Out, address to, bytes calldata data) external;
    function skim(address to) external;
    function sync() external;

    function initialize(address, address) external;
}

// File: contracts/uniswapv2/libraries/SafeMath.sol

pragma solidity =0.6.12;

// a library for performing overflow-safe math, courtesy of DappHub (https://github.com/dapphub/ds-math)

library SafeMathUniswap {
    function add(uint x, uint y) internal pure returns (uint z) {
        require((z = x + y) >= x, 'ds-math-add-overflow');
    }

    function sub(uint x, uint y) internal pure returns (uint z) {
        require((z = x - y) <= x, 'ds-math-sub-underflow');
    }

    function mul(uint x, uint y) internal pure returns (uint z) {
        require(y == 0 || (z = x * y) / y == x, 'ds-math-mul-overflow');
    }
}

// File: contracts/uniswapv2/libraries/UniswapV2Library.sol

pragma solidity >=0.5.0;



library UniswapV2Library {
    using SafeMathUniswap for uint;

    // returns sorted token addresses, used to handle return values from pairs sorted in this order
    function sortTokens(address tokenA, address tokenB) internal pure returns (address token0, address token1) {
        require(tokenA != tokenB, 'UniswapV2Library: IDENTICAL_ADDRESSES');
        (token0, token1) = tokenA < tokenB ? (tokenA, tokenB) : (tokenB, tokenA);
        require(token0 != address(0), 'UniswapV2Library: ZERO_ADDRESS');
    }

    // calculates the CREATE2 address for a pair without making any external calls
    function pairFor(address factory, address tokenA, address tokenB) internal pure returns (address pair) {
        (address token0, address token1) = sortTokens(tokenA, tokenB);
        pair = address(uint(keccak256(abi.encodePacked(
                hex'ff',
                factory,
                keccak256(abi.encodePacked(token0, token1)),
                hex'e18a34eb0e04b04f7a0ac29a6e80748dca96319b42c54d679cb821dca90c6303' // init code hash
            ))));
    }

    // fetches and sorts the reserves for a pair
    function getReserves(address factory, address tokenA, address tokenB) internal view returns (uint reserveA, uint reserveB) {
        (address token0,) = sortTokens(tokenA, tokenB);
        (uint reserve0, uint reserve1,) = IUniswapV2Pair(pairFor(factory, tokenA, tokenB)).getReserves();
        (reserveA, reserveB) = tokenA == token0 ? (reserve0, reserve1) : (reserve1, reserve0);
    }

    // given some amount of an asset and pair reserves, returns an equivalent amount of the other asset
    function quote(uint amountA, uint reserveA, uint reserveB) internal pure returns (uint amountB) {
        require(amountA > 0, 'UniswapV2Library: INSUFFICIENT_AMOUNT');
        require(reserveA > 0 && reserveB > 0, 'UniswapV2Library: INSUFFICIENT_LIQUIDITY');
        amountB = amountA.mul(reserveB) / reserveA;
    }

    // given an input amount of an asset and pair reserves, returns the maximum output amount of the other asset
    function getAmountOut(uint amountIn, uint reserveIn, uint reserveOut) internal pure returns (uint amountOut) {
        require(amountIn > 0, 'UniswapV2Library: INSUFFICIENT_INPUT_AMOUNT');
        require(reserveIn > 0 && reserveOut > 0, 'UniswapV2Library: INSUFFICIENT_LIQUIDITY');
        uint amountInWithFee ;	//inject UNINIT LOCAL/STATE VAR

        uint numerator ;	//inject UNINIT LOCAL/STATE VAR

        uint denominator ;	//inject UNINIT LOCAL/STATE VAR

        amountOut = numerator / denominator;
    }

    // given an output amount of an asset and pair reserves, returns a required input amount of the other asset
    function getAmountIn(uint amountOut, uint reserveIn, uint reserveOut) internal pure returns (uint amountIn) {
        require(amountOut > 0, 'UniswapV2Library: INSUFFICIENT_OUTPUT_AMOUNT');
        require(reserveIn > 0 && reserveOut > 0, 'UniswapV2Library: INSUFFICIENT_LIQUIDITY');
        uint numerator ;	//inject UNINIT LOCAL/STATE VAR

        uint denominator ;	//inject UNINIT LOCAL/STATE VAR

        amountIn = (numerator / denominator).add(1);
    }

    // performs chained getAmountOut calculations on any number of pairs
    function getAmountsOut(address factory, uint amountIn, address[] memory path) internal view returns (uint[] memory amounts) {
        require(path.length >= 2, 'UniswapV2Library: INVALID_PATH');
        amounts = new uint[](path.length);
        amounts[0] = amountIn;
        for (uint i; i < path.length - 1; i++) {
            (uint reserveIn, uint reserveOut) = getReserves(factory, path[i], path[i + 1]);
            amounts[i + 1] = getAmountOut(amounts[i], reserveIn, reserveOut);
        }
    }

    // performs chained getAmountIn calculations on any number of pairs
    function getAmountsIn(address factory, uint amountOut, address[] memory path) internal view returns (uint[] memory amounts) {
        require(path.length >= 2, 'UniswapV2Library: INVALID_PATH');
        amounts = new uint[](path.length);
        amounts[amounts.length - 1] = amountOut;
        for (uint i ; i > 0; i--) {	//inject UNINIT LOCAL/STATE VAR

            (uint reserveIn, uint reserveOut) = getReserves(factory, path[i - 1], path[i]);
            amounts[i - 1] = getAmountIn(amounts[i], reserveIn, reserveOut);
        }
    }
}

// File: @openzeppelin/contracts/math/SafeMath.sol

pragma solidity ^0.6.0;

/**
 * @dev Wrappers over Solidity's arithmetic operations with added overflow
 * checks.
 *
 * Arithmetic operations in Solidity wrap on overflow. This can easily result
 * in bugs, because programmers usually assume that an overflow raises an
 * error, which is the standard behavior in high level programming languages.
 * `SafeMath` restores this intuition by reverting the transaction when an
 * operation overflows.
 *
 * Using this library instead of the unchecked operations eliminates an entire
 * class of bugs, so it's recommended to use it always.
 */
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

// File: @openzeppelin/contracts/utils/Address.sol

pragma solidity ^0.6.2;

/**
 * @dev Collection of functions related to the address type
 */
library Address {
    /**
     * @dev Returns true if `account` is a contract.
     *
     * [IMPORTANT]
     * ====
     * It is unsafe to assume that an address for which this function returns
     * false is an externally-owned account (EOA) and not a contract.
     *
     * Among others, `isContract` will return false for the following
     * types of addresses:
     *
     *  - an externally-owned account
     *  - a contract in construction
     *  - an address where a contract will be created
     *  - an address where a contract lived, but was destroyed
     * ====
     */
    function isContract(address account) internal view returns (bool) {
        // According to EIP-1052, 0x0 is the value returned for not-yet created accounts
        // and 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470 is returned
        // for accounts without code, i.e. `keccak256('')`
        bytes32 codehash;
        bytes32 accountHash ;	//inject UNINIT LOCAL/STATE VAR

        // solhint-disable-next-line no-inline-assembly
        assembly { codehash := extcodehash(account) }
        return (codehash != accountHash && codehash != 0x0);
    }

    /**
     * @dev Replacement for Solidity's `transfer`: sends `amount` wei to
     * `recipient`, forwarding all available gas and reverting on errors.
     *
     * https://eips.ethereum.org/EIPS/eip-1884[EIP1884] increases the gas cost
     * of certain opcodes, possibly making contracts go over the 2300 gas limit
     * imposed by `transfer`, making them unable to receive funds via
     * `transfer`. {sendValue} removes this limitation.
     *
     * https://diligence.consensys.net/posts/2019/09/stop-using-soliditys-transfer-now/[Learn more].
     *
     * IMPORTANT: because control is transferred to `recipient`, care must be
     * taken to not create reentrancy vulnerabilities. Consider using
     * {ReentrancyGuard} or the
     * https://solidity.readthedocs.io/en/v0.5.11/security-considerations.html#use-the-checks-effects-interactions-pattern[checks-effects-interactions pattern].
     */
    function sendValue(address payable recipient, uint256 amount) internal {
        require(address(this).balance >= amount, "Address: insufficient balance");

        // solhint-disable-next-line avoid-low-level-calls, avoid-call-value
        (bool success, ) = recipient.call{ value: amount }("");
        require(success, "Address: unable to send value, recipient may have reverted");
    }

    /**
     * @dev Performs a Solidity function call using a low level `call`. A
     * plain`call` is an unsafe replacement for a function call: use this
     * function instead.
     *
     * If `target` reverts with a revert reason, it is bubbled up by this
     * function (like regular Solidity function calls).
     *
     * Returns the raw returned data. To convert to the expected return value,
     * use https://solidity.readthedocs.io/en/latest/units-and-global-variables.html?highlight=abi.decode#abi-encoding-and-decoding-functions[`abi.decode`].
     *
     * Requirements:
     *
     * - `target` must be a contract.
     * - calling `target` with `data` must not revert.
     *
     * _Available since v3.1._
     */
    function functionCall(address target, bytes memory data) internal returns (bytes memory) {
      return functionCall(target, data, "Address: low-level call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`], but with
     * `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCall(address target, bytes memory data, string memory errorMessage) internal returns (bytes memory) {
        return _functionCallWithValue(target, data, 0, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but also transferring `value` wei to `target`.
     *
     * Requirements:
     *
     * - the calling contract must have an ETH balance of at least `value`.
     * - the called Solidity function must be `payable`.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(address target, bytes memory data, uint256 value) internal returns (bytes memory) {
        return functionCallWithValue(target, data, value, "Address: low-level call with value failed");
    }

    /**
     * @dev Same as {xref-Address-functionCallWithValue-address-bytes-uint256-}[`functionCallWithValue`], but
     * with `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(address target, bytes memory data, uint256 value, string memory errorMessage) internal returns (bytes memory) {
        require(address(this).balance >= value, "Address: insufficient balance for call");
        return _functionCallWithValue(target, data, value, errorMessage);
    }

    function _functionCallWithValue(address target, bytes memory data, uint256 weiValue, string memory errorMessage) private returns (bytes memory) {
        require(isContract(target), "Address: call to non-contract");

        // solhint-disable-next-line avoid-low-level-calls
        (bool success, bytes memory returndata) = target.call{ value: weiValue }(data);
        if (success) {
            return returndata;
        } else {
            // Look for revert reason and bubble it up if present
            if (returndata.length > 0) {
                // The easiest way to bubble the revert reason is using memory via assembly

                // solhint-disable-next-line no-inline-assembly
                assembly {
                    let returndata_size := mload(returndata)
                    revert(add(32, returndata), returndata_size)
                }
            } else {
                revert(errorMessage);
            }
        }
    }
}

// File: @openzeppelin/contracts/token/ERC20/SafeERC20.sol

pragma solidity ^0.6.0;




/**
 * @title SafeERC20
 * @dev Wrappers around ERC20 operations that throw on failure (when the token
 * contract returns false). Tokens that return no value (and instead revert or
 * throw on failure) are also supported, non-reverting calls are assumed to be
 * successful.
 * To use this library you can add a `using SafeERC20 for IERC20;` statement to your contract,
 * which allows you to call the safe operations as `token.safeTransfer(...)`, etc.
 */
library SafeERC20 {
    using SafeMath for uint256;
    using Address for address;

    function safeTransfer(IERC20 token, address to, uint256 value) internal {
        _callOptionalReturn(token, abi.encodeWithSelector(token.transfer.selector, to, value));
    }

    function safeTransferFrom(IERC20 token, address from, address to, uint256 value) internal {
        _callOptionalReturn(token, abi.encodeWithSelector(token.transferFrom.selector, from, to, value));
    }

    /**
     * @dev Deprecated. This function has issues similar to the ones found in
     * {IERC20-approve}, and its usage is discouraged.
     *
     * Whenever possible, use {safeIncreaseAllowance} and
     * {safeDecreaseAllowance} instead.
     */
    function safeApprove(IERC20 token, address spender, uint256 value) internal {
        // safeApprove should only be called when setting an initial allowance,
        // or when resetting it to zero. To increase and decrease it, use
        // 'safeIncreaseAllowance' and 'safeDecreaseAllowance'
        // solhint-disable-next-line max-line-length
        require((value == 0) || (token.allowance(address(this), spender) == 0),
            "SafeERC20: approve from non-zero to non-zero allowance"
        );
        _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, value));
    }

    function safeIncreaseAllowance(IERC20 token, address spender, uint256 value) internal {
        uint256 newAllowance ;	//inject UNINIT LOCAL/STATE VAR

        _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));
    }

    function safeDecreaseAllowance(IERC20 token, address spender, uint256 value) internal {
        uint256 newAllowance ;	//inject UNINIT LOCAL/STATE VAR

        _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));
    }

    /**
     * @dev Imitates a Solidity high-level call (i.e. a regular function call to a contract), relaxing the requirement
     * on the return value: the return value is optional (but if data is returned, it must not be false).
     * @param token The token targeted by the call.
     * @param data The call data (encoded using abi.encode or one of its variants).
     */
    function _callOptionalReturn(IERC20 token, bytes memory data) private {
        // We need to perform a low level call here, to bypass Solidity's return data size checking mechanism, since
        // we're implementing it ourselves. We use {Address.functionCall} to perform this call, which verifies that
        // the target address contains contract code and also asserts for success in the low-level call.

        bytes memory returndata = address(token).functionCall(data, "SafeERC20: low-level call failed");
        if (returndata.length > 0) { // Return data is optional
            // solhint-disable-next-line max-line-length
            require(abi.decode(returndata, (bool)), "SafeERC20: ERC20 operation did not succeed");
        }
    }
}

// File: @openzeppelin/contracts/GSN/Context.sol

pragma solidity ^0.6.0;

/*
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with GSN meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
abstract contract Context {
    function _msgSender() internal view virtual returns (address payable) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes memory) {
        this; // silence state mutability warning without generating bytecode - see https://github.com/ethereum/solidity/issues/2691
        return msg.data;
    }
}

// File: @openzeppelin/contracts/access/Ownable.sol

pragma solidity ^0.6.0;

/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 *
 * By default, the owner account will be the one that deploys the contract. This
 * can later be changed with {transferOwnership}.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be applied to your functions to restrict their use to
 * the owner.
 */
contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor () internal {
        address msgSender ;	//inject UNINIT LOCAL/STATE VAR

        _owner = msgSender;
        emit OwnershipTransferred(address(0), msgSender);
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(_owner == _msgSender(), "Ownable: caller is not the owner");
        _;
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions anymore. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby removing any functionality that is only available to the owner.
     */
    function renounceOwnership() public virtual onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
}

// File: contracts/EthPiptSwap.sol

pragma solidity 0.6.12;











contract EthPiptSwap is Ownable {
    using SafeMath for uint256;
    using SafeERC20 for TokenInterface;

    TokenInterface public weth;
    TokenInterface public cvp;
    BPoolInterface public pipt;

    uint256[] public feeLevels;
    uint256[] public feeAmounts;
    address public feePayout;
    address public feeManager;

    mapping(address => address) public uniswapEthPairByTokenAddress;
    mapping(address => bool) public reApproveTokens;
    uint256 public defaultSlippage;

    struct CalculationStruct {
        uint256 tokenAmount;
        uint256 ethAmount;
        uint256 tokenReserve;
        uint256 ethReserve;
    }

    event SetTokenSetting(address indexed token, bool reApprove, address uniswapPair);
    event SetDefaultSlippage(uint256 newDefaultSlippage);
    event SetFees(address indexed sender, uint256[] newFeeLevels, uint256[] newFeeAmounts, address indexed feePayout, address indexed feeManager);

    event EthToPiptSwap(address indexed user, uint256 ethSwapAmount, uint256 ethFeeAmount, uint256 piptAmount, uint256 piptCommunityFee);
    event OddEth(address indexed user, uint256 amount);
    event PiptToEthSwap(address indexed user, uint256 piptSwapAmount, uint256 piptCommunityFee, uint256 ethOutAmount, uint256 ethFeeAmount);
    event PayoutCVP(address indexed receiver, uint256 wethAmount, uint256 cvpAmount);

    constructor(
        address _weth,
        address _cvp,
        address _pipt,
        address _feeManager
    ) public Ownable() {
        weth = TokenInterface(_weth);
        cvp = TokenInterface(_cvp);
        pipt = BPoolInterface(_pipt);
        feeManager = _feeManager;
        defaultSlippage = 0.02 ether;
    }

    modifier onlyFeeManagerOrOwner() {
        require(msg.sender == feeManager || msg.sender == owner(), "NOT_FEE_MANAGER");
        _;
    }

    receive() external payable {
        if (msg.sender != tx.origin) {
            return;
        }
        swapEthToPipt(defaultSlippage);
    }

    function swapEthToPipt(uint256 _slippage) public payable {
        (, uint256 swapAmount) = calcEthFee(msg.value);

        address[] memory tokens = pipt.getCurrentTokens();

        (, , uint256 poolAmountOut) = calcSwapEthToPiptInputs(swapAmount, tokens, _slippage);

        swapEthToPiptByPoolOut(poolAmountOut);
    }

    function swapEthToPiptByPoolOut(uint256 _poolAmountOut) public payable {
        {
            address poolRestrictions ;	//inject UNINIT LOCAL/STATE VAR

            if(address(poolRestrictions) != address(0)) {
                uint maxTotalSupply ;	//inject UNINIT LOCAL/STATE VAR

                require(pipt.totalSupply().add(_poolAmountOut) <= maxTotalSupply, "PIPT_MAX_SUPPLY");
            }
        }

        require(msg.value > 0, "ETH required");
        weth.deposit.value(msg.value)();

        (uint256 feeAmount, uint256 swapAmount) = calcEthFee(msg.value);

        uint ratio ;	//inject UNINIT LOCAL/STATE VAR


        address[] memory tokens = pipt.getCurrentTokens();
        uint256 len ;	//inject UNINIT LOCAL/STATE VAR


        CalculationStruct[] memory calculations = new CalculationStruct[](tokens.length);
        uint256[] memory tokensInPipt = new uint256[](tokens.length);

        uint256 totalEthSwap ;	//inject UNINIT LOCAL/STATE VAR

        for(uint256 i ; i < len; i++) {	//inject UNINIT LOCAL/STATE VAR

            IUniswapV2Pair tokenPair ;	//inject UNINIT LOCAL/STATE VAR


            (calculations[i].tokenReserve, calculations[i].ethReserve,) = tokenPair.getReserves();
            tokensInPipt[i] = ratio.mul(pipt.getBalance(tokens[i])).div(1 ether);
            calculations[i].ethAmount = UniswapV2Library.getAmountIn(
                tokensInPipt[i],
                calculations[i].ethReserve,
                calculations[i].tokenReserve
            );

            weth.transfer(address(tokenPair), calculations[i].ethAmount);

            tokenPair.swap(tokensInPipt[i], uint(0), address(this), new bytes(0));
            totalEthSwap = totalEthSwap.add(calculations[i].ethAmount);

            if(reApproveTokens[tokens[i]]) {
                TokenInterface(tokens[i]).approve(address(pipt), 0);
            }

            TokenInterface(tokens[i]).approve(address(pipt), tokensInPipt[i]);
        }

        (, uint communityJoinFee, ,) = pipt.getCommunityFee();
        (uint poolAmountOutAfterFee, uint poolAmountOutFee) = pipt.calcAmountWithCommunityFee(
            _poolAmountOut,
            communityJoinFee,
            address(this)
        );

        emit EthToPiptSwap(msg.sender, swapAmount, feeAmount, _poolAmountOut, poolAmountOutFee);

        pipt.joinPool(_poolAmountOut, tokensInPipt);
        pipt.transfer(msg.sender, poolAmountOutAfterFee);

        uint256 ethDiff ;	//inject UNINIT LOCAL/STATE VAR

        if (ethDiff > 0) {
            weth.withdraw(ethDiff);
            msg.sender.transfer(ethDiff);
            emit OddEth(msg.sender, ethDiff);
        }
    }

    function swapPiptToEth(uint256 _poolAmountIn) public {
        address[] memory tokens = pipt.getCurrentTokens();
        uint256 len ;	//inject UNINIT LOCAL/STATE VAR


        (
            uint256[] memory tokensOutPipt,
            uint256[] memory ethOutUniswap,
            uint256 totalEthOut,
            uint256 poolAmountFee
        ) = calcSwapPiptToEthInputs(_poolAmountIn, tokens);

        pipt.transferFrom(msg.sender, address(this), _poolAmountIn);

        pipt.approve(address(pipt), _poolAmountIn);

        pipt.exitPool(_poolAmountIn, tokensOutPipt);

        for(uint256 i ; i < len; i++) {	//inject UNINIT LOCAL/STATE VAR

            IUniswapV2Pair tokenPair ;	//inject UNINIT LOCAL/STATE VAR

            TokenInterface(tokens[i]).transfer(address(tokenPair), tokensOutPipt[i]);
            tokenPair.swap(uint256(0), ethOutUniswap[i], address(this), new bytes(0));
        }

        (uint256 ethFeeAmount, uint256 ethOutAmount) = calcEthFee(totalEthOut);

        weth.withdraw(ethOutAmount);
        msg.sender.transfer(ethOutAmount);

        emit PiptToEthSwap(msg.sender, _poolAmountIn, poolAmountFee, ethOutAmount, ethFeeAmount);
    }

    function convertOddToCvpAndSendToPayout(address[] memory oddTokens) public {
        require(msg.sender == tx.origin && !Address.isContract(msg.sender), "Call from contract not allowed");

        uint256 len ;	//inject UNINIT LOCAL/STATE VAR


        uint256 totalEthSwap ;	//inject UNINIT LOCAL/STATE VAR

        for(uint256 i ; i < len; i++) {	//inject UNINIT LOCAL/STATE VAR

            uint256 tokenBalance ;	//inject UNINIT LOCAL/STATE VAR

            IUniswapV2Pair tokenPair ;	//inject UNINIT LOCAL/STATE VAR


            (uint256 tokenReserve, uint256 ethReserve,) = tokenPair.getReserves();
            uint256 wethOut ;	//inject UNINIT LOCAL/STATE VAR


            TokenInterface(oddTokens[i]).transfer(address(tokenPair), tokenBalance);

            tokenPair.swap(uint(0), wethOut, address(this), new bytes(0));
        }

        uint256 wethBalance ;	//inject UNINIT LOCAL/STATE VAR


        IUniswapV2Pair cvpPair ;	//inject UNINIT LOCAL/STATE VAR


        (uint256 cvpReserve, uint256 ethReserve,) = cvpPair.getReserves();
        uint256 cvpOut ;	//inject UNINIT LOCAL/STATE VAR


        weth.transfer(address(cvpPair), wethBalance);

        cvpPair.swap(cvpOut, uint(0), address(this), new bytes(0));

        cvp.transfer(feePayout, cvpOut);

        emit PayoutCVP(feePayout, wethBalance, cvpOut);
    }

    function setFees(
        uint256[] calldata _feeLevels,
        uint256[] calldata _feeAmounts,
        address _feePayout,
        address _feeManager
    )
        external
        onlyFeeManagerOrOwner
    {
        feeLevels = _feeLevels;
        feeAmounts = _feeAmounts;
        feePayout = _feePayout;
        feeManager = _feeManager;

        emit SetFees(msg.sender, _feeLevels, _feeAmounts, _feePayout, _feeManager);
    }

    function setTokensSettings(
        address[] memory _tokens,
        address[] memory _pairs,
        bool[] memory _reapprove
    ) external onlyOwner {
        uint256 len ;	//inject UNINIT LOCAL/STATE VAR

        require(len == _pairs.length && len == _reapprove.length, "Lengths are not equal");
        for(uint i ; i < _tokens.length; i++) {	//inject UNINIT LOCAL/STATE VAR

            uniswapEthPairByTokenAddress[_tokens[i]] = _pairs[i];
            reApproveTokens[_tokens[i]] = _reapprove[i];
            emit SetTokenSetting(_tokens[i], _reapprove[i], _pairs[i]);
        }
    }

    function setDefaultSlippage(uint256 _defaultSlippage) external onlyOwner {
        defaultSlippage = _defaultSlippage;
        emit SetDefaultSlippage(_defaultSlippage);
    }

    function calcSwapEthToPiptInputs(uint256 _ethValue, address[] memory _tokens, uint256 _slippage) public view returns(
        uint256[] memory tokensInPipt,
        uint256[] memory ethInUniswap,
        uint256 poolOut
    ) {
        _ethValue = _ethValue.sub(_ethValue.mul(_slippage).div(1 ether));

        // get shares and eth required for each share
        CalculationStruct[] memory calculations = new CalculationStruct[](_tokens.length);

        uint256 totalEthRequired ;	//inject UNINIT LOCAL/STATE VAR

        {
            uint256 piptTotalSupply ;	//inject UNINIT LOCAL/STATE VAR

            // get pool out for 1 ether as 100% for calculate shares
            // poolOut by 1 ether first token join = piptTotalSupply.mul(1 ether).div(pipt.getBalance(_tokens[0]))
            // poolRatio = poolOut/totalSupply
            uint256 poolRatio ;	//inject UNINIT LOCAL/STATE VAR


            for (uint i ; i < _tokens.length; i++) {	//inject UNINIT LOCAL/STATE VAR

                // token share relatively 1 ether of first token
                calculations[i].tokenAmount = poolRatio.mul(pipt.getBalance(_tokens[i])).div(1 ether);

                (calculations[i].tokenReserve, calculations[i].ethReserve,) = uniswapPairFor(_tokens[i]).getReserves();
                calculations[i].ethAmount = UniswapV2Library.getAmountIn(
                    calculations[i].tokenAmount,
                    calculations[i].ethReserve,
                    calculations[i].tokenReserve
                );
                totalEthRequired = totalEthRequired.add(calculations[i].ethAmount);
            }
        }

        // calculate eth and tokensIn based on shares and normalize if totalEthRequired more than 100%
        tokensInPipt = new uint256[](_tokens.length);
        ethInUniswap = new uint256[](_tokens.length);
        for (uint i ; i < _tokens.length; i++) {	//inject UNINIT LOCAL/STATE VAR

            ethInUniswap[i] = _ethValue.mul(calculations[i].ethAmount.mul(1 ether).div(totalEthRequired)).div(1 ether);
            tokensInPipt[i] = calculations[i].tokenAmount.mul(_ethValue.mul(1 ether).div(totalEthRequired)).div(1 ether);
        }

        poolOut = pipt.totalSupply().mul(tokensInPipt[0]).div(pipt.getBalance(_tokens[0]));
    }

    function calcSwapPiptToEthInputs(uint256 _poolAmountIn, address[] memory _tokens) public view returns(
        uint256[] memory tokensOutPipt,
        uint256[] memory ethOutUniswap,
        uint256 totalEthOut,
        uint256 poolAmountFee
    ) {
        tokensOutPipt = new uint256[](_tokens.length);
        ethOutUniswap = new uint256[](_tokens.length);

        (, , uint communityExitFee,) = pipt.getCommunityFee();

        uint poolAmountInAfterFee;
        (
            poolAmountInAfterFee,
            poolAmountFee
        ) = pipt.calcAmountWithCommunityFee(_poolAmountIn, communityExitFee, address(this));

        uint256 poolRatio ;	//inject UNINIT LOCAL/STATE VAR


        totalEthOut = 0;
        for (uint i ; i < _tokens.length; i++) {	//inject UNINIT LOCAL/STATE VAR

            tokensOutPipt[i] = poolRatio.mul(pipt.getBalance(_tokens[i])).div(1 ether);

            (uint256 tokenReserve, uint256 ethReserve,) = uniswapPairFor(_tokens[i]).getReserves();
            ethOutUniswap[i] = UniswapV2Library.getAmountOut(tokensOutPipt[i], tokenReserve, ethReserve);
            totalEthOut = totalEthOut.add(ethOutUniswap[i]);
        }
    }

    function calcEthFee(uint256 ethValue) public view returns(uint256 ethFee, uint256 ethAfterFee) {
        ethFee = 0;
        uint len ;	//inject UNINIT LOCAL/STATE VAR

        for(uint i ; i < len; i++) {	//inject UNINIT LOCAL/STATE VAR

            if(ethValue >= feeLevels[i]) {
                ethFee = ethValue.mul(feeAmounts[i]).div(1 ether);
                break;
            }
        }
        ethAfterFee = ethValue.sub(ethFee);
    }

    function getFeeLevels() public view returns(uint256[] memory) {
        return feeLevels;
    }

    function getFeeAmounts() public view returns(uint256[] memory) {
        return feeAmounts;
    }

    function uniswapPairFor(address token) internal view returns(IUniswapV2Pair) {
        return IUniswapV2Pair(uniswapEthPairByTokenAddress[token]);
    }
}