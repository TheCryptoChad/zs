export const blueprintCollectionABI = [
  {
    anonymous: false,
    inputs: [
      {
        indexed: false,
        internalType: 'uint256',
        name: 'blueprintId',
        type: 'uint256',
      },
    ],
    name: 'BlueprintAdded',
    type: 'event',
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: false,
        internalType: 'uint256',
        name: 'blueprintId',
        type: 'uint256',
      },
      {
        indexed: false,
        internalType: 'address',
        name: 'recipient',
        type: 'address',
      },
      {
        indexed: false,
        internalType: 'uint256',
        name: 'amount',
        type: 'uint256',
      },
    ],
    name: 'BlueprintCrafted',
    type: 'event',
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: false,
        internalType: 'uint256',
        name: 'blueprintId',
        type: 'uint256',
      },
      {
        indexed: false,
        internalType: 'address',
        name: 'inputTarget',
        type: 'address',
      },
    ],
    name: 'BlueprintInputTargetChanged',
    type: 'event',
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: false,
        internalType: 'uint256',
        name: 'blueprintId',
        type: 'uint256',
      },
      {
        indexed: false,
        internalType: 'uint256',
        name: 'availableToMint',
        type: 'uint256',
      },
    ],
    name: 'BlueprintMintNumChanged',
    type: 'event',
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: false,
        internalType: 'bytes32',
        name: 'tag',
        type: 'bytes32',
      },
      {
        indexed: false,
        internalType: 'uint256',
        name: 'blueprintId',
        type: 'uint256',
      },
      {
        indexed: false,
        internalType: 'address',
        name: 'recipient',
        type: 'address',
      },
      {
        indexed: false,
        internalType: 'uint256',
        name: 'amount',
        type: 'uint256',
      },
    ],
    name: 'BlueprintSigCrafted',
    type: 'event',
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: true,
        internalType: 'bytes32',
        name: 'role',
        type: 'bytes32',
      },
      {
        indexed: true,
        internalType: 'bytes32',
        name: 'previousAdminRole',
        type: 'bytes32',
      },
      {
        indexed: true,
        internalType: 'bytes32',
        name: 'newAdminRole',
        type: 'bytes32',
      },
    ],
    name: 'RoleAdminChanged',
    type: 'event',
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: true,
        internalType: 'bytes32',
        name: 'role',
        type: 'bytes32',
      },
      {
        indexed: true,
        internalType: 'address',
        name: 'account',
        type: 'address',
      },
      {
        indexed: true,
        internalType: 'address',
        name: 'sender',
        type: 'address',
      },
    ],
    name: 'RoleGranted',
    type: 'event',
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: true,
        internalType: 'bytes32',
        name: 'role',
        type: 'bytes32',
      },
      {
        indexed: true,
        internalType: 'address',
        name: 'account',
        type: 'address',
      },
      {
        indexed: true,
        internalType: 'address',
        name: 'sender',
        type: 'address',
      },
    ],
    name: 'RoleRevoked',
    type: 'event',
  },
  {
    inputs: [],
    name: 'ADMIN_ROLE',
    outputs: [
      {
        internalType: 'bytes32',
        name: '',
        type: 'bytes32',
      },
    ],
    stateMutability: 'view',
    type: 'function',
  },
  {
    inputs: [],
    name: 'DEFAULT_ADMIN_ROLE',
    outputs: [
      {
        internalType: 'bytes32',
        name: '',
        type: 'bytes32',
      },
    ],
    stateMutability: 'view',
    type: 'function',
  },
  {
    inputs: [],
    name: 'GOVERNANCE_ROLE',
    outputs: [
      {
        internalType: 'bytes32',
        name: '',
        type: 'bytes32',
      },
    ],
    stateMutability: 'view',
    type: 'function',
  },
  {
    inputs: [],
    name: 'OPERATOR_ROLE',
    outputs: [
      {
        internalType: 'bytes32',
        name: '',
        type: 'bytes32',
      },
    ],
    stateMutability: 'view',
    type: 'function',
  },
  {
    inputs: [],
    name: 'VERSION',
    outputs: [
      {
        internalType: 'uint16',
        name: '',
        type: 'uint16',
      },
    ],
    stateMutability: 'view',
    type: 'function',
  },
  {
    inputs: [
      {
        components: [
          {
            internalType: 'enum DomainV4.CraftMode',
            name: 'mode',
            type: 'uint8',
          },
          {
            internalType: 'address',
            name: 'inputTarget',
            type: 'address',
          },
          {
            internalType: 'uint256',
            name: 'availableToMint',
            type: 'uint256',
          },
          {
            internalType: 'uint256[]',
            name: 'inputAssetAmounts',
            type: 'uint256[]',
          },
          {
            components: [
              {
                internalType: 'uint256',
                name: 'assetId',
                type: 'uint256',
              },
              {
                internalType: 'address',
                name: 'assetAddress',
                type: 'address',
              },
              {
                internalType: 'enum DomainV4.AssetType',
                name: 'assetType',
                type: 'uint8',
              },
            ],
            internalType: 'struct DomainV4.Asset[]',
            name: 'inputAssets',
            type: 'tuple[]',
          },
          {
            internalType: 'uint256[]',
            name: 'outputAssetAmounts',
            type: 'uint256[]',
          },
          {
            components: [
              {
                internalType: 'uint256',
                name: 'assetId',
                type: 'uint256',
              },
              {
                internalType: 'address',
                name: 'assetAddress',
                type: 'address',
              },
              {
                internalType: 'enum DomainV4.AssetType',
                name: 'assetType',
                type: 'uint8',
              },
            ],
            internalType: 'struct DomainV4.Asset[]',
            name: 'outputAssets',
            type: 'tuple[]',
          },
          {
            components: [
              {
                internalType: 'address',
                name: 'target',
                type: 'address',
              },
              {
                internalType: 'bytes',
                name: 'data',
                type: 'bytes',
              },
            ],
            internalType: 'struct DomainV4.CallData[]',
            name: 'outputCalldatas',
            type: 'tuple[]',
          },
        ],
        internalType: 'struct DomainV4.Blueprint',
        name: '_bp',
        type: 'tuple',
      },
    ],
    name: 'addBlueprint',
    outputs: [],
    stateMutability: 'nonpayable',
    type: 'function',
  },
  {
    inputs: [
      {
        internalType: 'uint256',
        name: '_id',
        type: 'uint256',
      },
    ],
    name: 'blueprint',
    outputs: [],
    stateMutability: 'view',
    type: 'function',
  },
  {
    inputs: [
      {
        internalType: 'uint256',
        name: '_startIdInclusive',
        type: 'uint256',
      },
      {
        internalType: 'uint256',
        name: '_endIdExclusive',
        type: 'uint256',
      },
    ],
    name: 'blueprints',
    outputs: [
      {
        components: [
          {
            internalType: 'enum DomainV4.CraftMode',
            name: 'mode',
            type: 'uint8',
          },
          {
            internalType: 'address',
            name: 'inputTarget',
            type: 'address',
          },
          {
            internalType: 'uint256',
            name: 'availableToMint',
            type: 'uint256',
          },
          {
            internalType: 'uint256[]',
            name: 'inputAssetAmounts',
            type: 'uint256[]',
          },
          {
            components: [
              {
                internalType: 'uint256',
                name: 'assetId',
                type: 'uint256',
              },
              {
                internalType: 'address',
                name: 'assetAddress',
                type: 'address',
              },
              {
                internalType: 'enum DomainV4.AssetType',
                name: 'assetType',
                type: 'uint8',
              },
            ],
            internalType: 'struct DomainV4.Asset[]',
            name: 'inputAssets',
            type: 'tuple[]',
          },
          {
            internalType: 'uint256[]',
            name: 'outputAssetAmounts',
            type: 'uint256[]',
          },
          {
            components: [
              {
                internalType: 'uint256',
                name: 'assetId',
                type: 'uint256',
              },
              {
                internalType: 'address',
                name: 'assetAddress',
                type: 'address',
              },
              {
                internalType: 'enum DomainV4.AssetType',
                name: 'assetType',
                type: 'uint8',
              },
            ],
            internalType: 'struct DomainV4.Asset[]',
            name: 'outputAssets',
            type: 'tuple[]',
          },
          {
            components: [
              {
                internalType: 'address',
                name: 'target',
                type: 'address',
              },
              {
                internalType: 'bytes',
                name: 'data',
                type: 'bytes',
              },
            ],
            internalType: 'struct DomainV4.CallData[]',
            name: 'outputCalldatas',
            type: 'tuple[]',
          },
        ],
        internalType: 'struct DomainV4.Blueprint[]',
        name: '',
        type: 'tuple[]',
      },
    ],
    stateMutability: 'view',
    type: 'function',
  },
  {
    inputs: [],
    name: 'collectionIdentifier',
    outputs: [
      {
        internalType: 'uint256',
        name: '',
        type: 'uint256',
      },
    ],
    stateMutability: 'view',
    type: 'function',
  },
  {
    inputs: [
      {
        internalType: 'uint256',
        name: '_bpId',
        type: 'uint256',
      },
      {
        internalType: 'uint256',
        name: '_amount',
        type: 'uint256',
      },
    ],
    name: 'craft',
    outputs: [],
    stateMutability: 'payable',
    type: 'function',
  },
  {
    inputs: [
      {
        internalType: 'bytes',
        name: 'data',
        type: 'bytes',
      },
      {
        internalType: 'bytes',
        name: 'signature',
        type: 'bytes',
      },
    ],
    name: 'craftSig',
    outputs: [],
    stateMutability: 'payable',
    type: 'function',
  },
  {
    inputs: [
      {
        internalType: 'bytes32',
        name: 'role',
        type: 'bytes32',
      },
    ],
    name: 'getRoleAdmin',
    outputs: [
      {
        internalType: 'bytes32',
        name: '',
        type: 'bytes32',
      },
    ],
    stateMutability: 'view',
    type: 'function',
  },
  {
    inputs: [
      {
        internalType: 'bytes32',
        name: 'role',
        type: 'bytes32',
      },
      {
        internalType: 'uint256',
        name: 'index',
        type: 'uint256',
      },
    ],
    name: 'getRoleMember',
    outputs: [
      {
        internalType: 'address',
        name: '',
        type: 'address',
      },
    ],
    stateMutability: 'view',
    type: 'function',
  },
  {
    inputs: [
      {
        internalType: 'bytes32',
        name: 'role',
        type: 'bytes32',
      },
    ],
    name: 'getRoleMemberCount',
    outputs: [
      {
        internalType: 'uint256',
        name: '',
        type: 'uint256',
      },
    ],
    stateMutability: 'view',
    type: 'function',
  },
  {
    inputs: [
      {
        internalType: 'bytes32',
        name: 'role',
        type: 'bytes32',
      },
      {
        internalType: 'address',
        name: 'account',
        type: 'address',
      },
    ],
    name: 'grantRole',
    outputs: [],
    stateMutability: 'nonpayable',
    type: 'function',
  },
  {
    inputs: [
      {
        internalType: 'bytes32',
        name: 'role',
        type: 'bytes32',
      },
      {
        internalType: 'address',
        name: 'account',
        type: 'address',
      },
    ],
    name: 'hasRole',
    outputs: [
      {
        internalType: 'bool',
        name: '',
        type: 'bool',
      },
    ],
    stateMutability: 'view',
    type: 'function',
  },
  {
    inputs: [
      {
        internalType: 'bytes32',
        name: '_tag',
        type: 'bytes32',
      },
    ],
    name: 'isTagAlreadyUsed',
    outputs: [
      {
        internalType: 'bool',
        name: '',
        type: 'bool',
      },
    ],
    stateMutability: 'view',
    type: 'function',
  },
  {
    inputs: [],
    name: 'numBlueprints',
    outputs: [
      {
        internalType: 'uint256',
        name: '',
        type: 'uint256',
      },
    ],
    stateMutability: 'view',
    type: 'function',
  },
  {
    inputs: [],
    name: 'parent',
    outputs: [
      {
        internalType: 'address',
        name: '',
        type: 'address',
      },
    ],
    stateMutability: 'view',
    type: 'function',
  },
  {
    inputs: [
      {
        internalType: 'bytes32',
        name: 'role',
        type: 'bytes32',
      },
      {
        internalType: 'address',
        name: 'account',
        type: 'address',
      },
    ],
    name: 'renounceRole',
    outputs: [],
    stateMutability: 'nonpayable',
    type: 'function',
  },
  {
    inputs: [
      {
        internalType: 'bytes32',
        name: 'role',
        type: 'bytes32',
      },
      {
        internalType: 'address',
        name: 'account',
        type: 'address',
      },
    ],
    name: 'revokeRole',
    outputs: [],
    stateMutability: 'nonpayable',
    type: 'function',
  },
  {
    inputs: [
      {
        internalType: 'uint256',
        name: '_bpId',
        type: 'uint256',
      },
      {
        internalType: 'address',
        name: '_inputTarget',
        type: 'address',
      },
    ],
    name: 'setBlueprintInputTarget',
    outputs: [],
    stateMutability: 'nonpayable',
    type: 'function',
  },
  {
    inputs: [
      {
        internalType: 'uint256',
        name: '_bpId',
        type: 'uint256',
      },
      {
        internalType: 'uint256',
        name: '_availableToMint',
        type: 'uint256',
      },
    ],
    name: 'setBlueprintMintsAvailable',
    outputs: [],
    stateMutability: 'nonpayable',
    type: 'function',
  },
  {
    inputs: [
      {
        internalType: 'bytes4',
        name: 'interfaceId',
        type: 'bytes4',
      },
    ],
    name: 'supportsInterface',
    outputs: [
      {
        internalType: 'bool',
        name: '',
        type: 'bool',
      },
    ],
    stateMutability: 'view',
    type: 'function',
  },
];
