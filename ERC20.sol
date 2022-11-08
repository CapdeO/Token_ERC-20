// SPDX-License-Identifier: MIT
pragma solidity >=0.4.4 < 0.7.0;
pragma experimental ABIEncoderV2;
import "./SafeMath.sol";

// Interface de nuestro token ERC20
// Métodos accesibles desde el exterior
interface IERC20{
    // Devuelve la cantidad de tokens en existencia
    function totalSupply() external view returns (uint256);

    // Devuelve la cantidad de tokens para una dirección indicada por parámetro
    function balanceOf(address account) external view returns (uint256);

    // Devuelve el número de tokens que el sender podrá gastar en nombre del propietario (owner) 
    function allowance(address owner, address spender) external view returns (uint256);

    // Devuelve un valor booleano resultado de la operación indicada
    function transfer(address recipient, uint256 amount) external returns (bool);

    // Devuelve un valor booleano con el resultado de la operación de gasto
    function approve(address spender, uint256 amount) external returns (bool);

    // Devuelve un valor booleano con el resultado de la operación de paso de una cantidad de tokens usando el método allowance()
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

    // Eventos para que todo el mundo sea notificado de las transacciones que vayan ocurriendo

    // Evento que se debe emitir cuando una cantidad de tokens pase de un origen a un destino
    event Transfer(address indexed from, address indexed to, uint256 value);

    // Evento que se debe emitir cuando se establece una asignación con el método allowance()
    event Approval(address indexed owner, address indexed spender, uint256 value);


}


// Implementación de las funciones del token ERC20
contract ERC20Basic is IERC20{

    // Variables públicas constantes del contrato
    string public constant name = "ERC20PruebaCoin";
    string public constant symbol = "PC";
    uint8 public constant decimals = 18;


    event Transfer(address indexed from, address indexed to, uint256 tokens);
    event Approval(address indexed owner, address indexed spender, uint256 tokens);

    // Todas las operaciones con enteros pasan por la librería para evitar el overflow
    // El overflow serían resultados de operaciones matemáticas que dan negativo por sobrepasar un límite
    using SafeMath for uint256;

    // Privadas

    // A cada dirección le corresponden tantos tokens
    mapping (address => uint) balances;
    // A cada dirección le corresponden un conjunto de direcciones con cantidad de cada una de ellas
    // "El que la mina la puede ceder a diferentes personas que la puedan gastar"
    mapping (address => mapping (address => uint)) allowed;
    // De nuestra moneda va a haber "tantas unidades"
    // El guón bajo es para que sea más facil de identificar
    // La distribución inicial de los tokens dará el valor 
    // La cantidad total sólo es establecida en el constructor, por
    // seguridad, nadie la puede modificar (si consultar)
    // Es privada, nadie puede acceder a ella y tocarla
    uint256 totalSupply_;

    // Definiendo con el constructor la cantidad total al momento de crearla
    constructor (uint256 initialSupply) public {
        totalSupply_ = initialSupply;
        // El emisor posee un balance con la cantidad global
        // El instante que se crea la moneda, "el universo"
        balances[msg.sender] = totalSupply_;
    }

    

    // Eso sería el "big bang", el "esqueleto"
    // Una vez que ya estamos en el punto de partida, ahora
    // creamos las funciones que van a dictaminar el funcionamiento
    // de todo
    // Cantidad total, balance, algún que otro método que nos va 
    // a hacer falta y lógica del token ERC20


    // Devuelve la cantidad total para que pueda ser consultada
    // desde afuera de la implementación del smart contract
    function totalSupply() public override view returns (uint256){
        return totalSupply_;
    }

    // Podemos definir que sea posible crear/minar nuevos tokens
    // modificando el suministro total
    function increaseTotalSupply(uint newTokensAmount) public {
        totalSupply_ += newTokensAmount;
        balances[msg.sender] += newTokensAmount;
    }

    // Devuelve el balance para la dirección de una persona determinada
    function balanceOf(address tokenOwner) public override view returns (uint256){
        return balances[tokenOwner];
    }

    // La función allowance nos devolverá esa cantidad que en principio
    // será 0, si el delegado no tiene ninguna cantidad relacionada con el
    // propietario, o si el delegado tiene cierta cantidad de tokens que el 
    // propietario le permite gastar 
    function allowance(address owner, address delegate) public override view returns (uint256){
        // Permitido que el propietario original pueda delegar
        // en otra dirección
        return allowed[owner][delegate];
    }


    // Enviar cantidad de tokens a un receptor
    // Primero debemos asegurar que como emisor dispongo de esos tokens
    function transfer(address recipient, uint256 numTokens) public override returns (bool){
        require(numTokens <= balances[msg.sender]);

        return false;
    }

    function approve(address spender, uint256 amount) public override returns (bool){
        return false;
    }

    function transferFrom(address sender, address recipient, uint256 amount) public override returns (bool){
        return false;
    }

}