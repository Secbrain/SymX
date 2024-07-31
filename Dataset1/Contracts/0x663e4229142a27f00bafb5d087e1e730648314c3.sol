/*
 * @source: etherscan.io 
 * @author: -
 * @vulnerable_at_lines: 1152,1496,2467
 */

/// @title A facet of PandaCore that manages Panda siring, gestation, and birth.
/// @author Axiom Zen (https://www.axiomzen.co)
/// @dev See the PandaCore contract documentation to understand how the various contract facets are arranged.
contract PandaBreeding {

    uint256 constant GENSIS_TOTAL_COUNT = 100;

    /// @dev The Pregnant event is fired when two cats successfully breed and the pregnancy
    ///  timer begins for the matron.
    event Pregnant(address owner, uint256 matronId, uint256 sireId, uint256 cooldownEndBlock);
    /// @dev The Abortion event is fired when two cats breed failed.
    event Abortion(address owner, uint256 matronId, uint256 sireId);

    /// @notice The minimum payment required to use breedWithAuto(). This fee goes towards
    ///  the gas cost paid by whatever calls giveBirth(), and can be dynamically updated by
    ///  the COO role as the gas price changes.
    uint256 autoBirthFee = 2 finney;

    // Keeps track of number of pregnant pandas.
    uint256 pregnantPandas;

    mapping(uint256 => address) childOwner;


    /// @notice Have a pregnant Panda give birth!
    /// @param _matronId A Panda ready to give birth.
    /// @return The Panda ID of the new kitten.
    /// @dev Looks at a given Panda and, if pregnant and if the gestation period has passed,
    ///  combines the genes of the two parents to create a new kitten. The new Panda is assigned
    ///  to the current owner of the matron. Upon successful completion, both the matron and the
    ///  new kitten will be ready to breed again. Note that anyone can call this function (if they
    ///  are willing to pay the gas!), but the new kitten always goes to the mother's owner.
    function giveBirth(uint256 _matronId, uint256[2] _childGenes, uint256[2] _factors)
    external
    returns(uint256) {
        uint256[2] memory childGenes = _childGenes;

        uint256 kittenId = 0;

        // Send the balance fee to the person who made birth happen.
         // <yes> <report> UNCHECKED_LL_CALLS
        msg.sender.send(autoBirthFee);


        // return the new kitten's ID
        return kittenId;
    }
}
