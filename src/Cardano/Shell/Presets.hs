module Cardano.Shell.Presets
    ( mainnetConfiguration
    , devConfiguration
    ) where

import           Cardano.Prelude

import           Cardano.Shell.Constants.PartialTypes (PartialBlock (..), PartialCardanoConfiguration (..),
                                                       PartialCertificate (..),
                                                       PartialCore (..),
                                                       PartialGenesis (..),
                                                       PartialNode (..),
                                                       PartialStaticKeyMaterial (..),
                                                       PartialTLS (..),
                                                       PartialThrottle (..),
                                                       PartialWallet (..))
import           Cardano.Shell.Constants.Types (DLG (..),
                                                LastKnownBlockVersion (..),
                                                NTP (..),
                                                RequireNetworkMagic (..),
                                                SSC (..), TXP (..), Update (..))

--------------------------------------------------------------------------------
-- Cardano Mainnet Configuration
--------------------------------------------------------------------------------

mainnetConfiguration :: PartialCardanoConfiguration
mainnetConfiguration =
  PartialCardanoConfiguration
    { pccLogPath             = pure "./logs/"
    , pccLogConfig           = pure "./configuration/log-configuration.yaml"
    , pccDBPath              = pure "./db/"
    , pccApplicationLockFile = pure ""
    , pccCore =
        pure PartialCore
          { pcoGenesis =
              pure PartialGenesis
                { pgeSrc             = pure "mainnet-genesis.json"
                , pgeGenesisHash     = pure "89d9b5a5b8ddc8d7e5a6795e9774d97faf1efea59b2caf7eaf9f8c5b32059df4"
                }
          , pcoStaticKeyMaterial =
              pure PartialStaticKeyMaterial
                { pskmSigningKeyFile = mempty
                , pskmDlgCertFile    = mempty
                }
          , pcoRequiresNetworkMagic = pure RequireNetworkMagic
          , pcoDBSerializeVersion   = pure 0
          }
    , pccNTP = pure
        NTP
          { ntpResponseTimeout = 30000000
          , ntpPollDelay       = 1800000000
          , ntpServers         =
              [ "0.pool.ntp.org"
              , "2.pool.ntp.org"
              , "3.pool.ntp.org"
              ]
          }
    , pccUpdate = pure
        Update
          { upApplicationName       = "cardano-sl"
          , upApplicationVersion    = 1
          , upLastKnownBlockVersion =
              LastKnownBlockVersion
                { lkbvMajor = 0
                , lkbvMinor = 2
                , lkbvAlt   = 0
                }
                                               }
    , pccTXP = pure
        TXP
          { txpMemPoolLimitTx = 200
          , txpAssetLockedSrcAddress = []
          }
    , pccSSC = pure
        SSC
          { sscMPCSendInterval               = 100
          , sscMdNoCommitmentsEpochThreshold = 3
          , sscNoReportNoSecretsForEpoch1    = True
          }
    , pccDLG = pure
        DLG { dlgCacheParam          = 500
            , dlgMessageCacheTimeout = 30
            }
    , pccBlock = pure
        PartialBlock
          { pblNetworkDiameter        = pure 18
          , pblRecoveryHeadersMessage = pure 2200
          , pblStreamWindow           = pure 2048
          , pblNonCriticalCQBootstrap = pure 0.95
          , pblNonCriticalCQ          = pure 0.8
          , pblCriticalCQBootstrap    = pure 0.8888
          , pblCriticalCQ             = pure 0.654321
          , pblCriticalForkThreshold  = pure 3
          , pblFixedTimeCQ            = pure 3600
          }
    , pccNode = pure
        PartialNode
          { pnoNetworkConnectionTimeout     = pure 15000
          , pnoConversationEstablishTimeout = pure 30000
          , pnoBlockRetrievalQueueSize      = pure 100
          , pnoPendingTxResubmissionPeriod  = pure 7
          , pnoWalletProductionApi          = pure True
          , pnoWalletTxCreationDisabled     = pure False
          , pnoExplorerExtendedApi          = pure False
          }
    , pccTLS = pure
        PartialTLS
          { ptlsCA =
              pure PartialCertificate
                { pcertOrganization = pure "Input Output HK"
                , pcertCommonName   = pure "Cardano SL Self-Signed Root CA"
                , pcertExpiryDays   = pure 3600
                , pcertAltDNS       = pure []
                }
          , ptlsServer =
              pure PartialCertificate
                { pcertOrganization = pure "Input Output HK"
                , pcertCommonName   = pure "Cardano SL Server Node"
                , pcertExpiryDays   = pure 3600
                , pcertAltDNS       = pure
                    [ "localhost"
                    , "localhost.localdomain"
                    , "127.0.0.1"
                    , "::1"
                    ]
                }
          , ptlsClients =
              pure PartialCertificate
                { pcertOrganization = pure "Input Output HK"
                , pcertCommonName   = pure "Daedalus Wallet"
                , pcertExpiryDays   = pure 3600
                , pcertAltDNS       = pure []
                }
          }
    , pccWallet =
        pure PartialWallet
          { pwaThrottle =
              pure PartialThrottle
                { pthEnabled = pure False
                , pthRate    = pure 0
                , pthPeriod  = pure ""
                , pthBurst   = pure 0
                }
          }
    }

--------------------------------------------------------------------------------
-- Cardano Dev Configuration
--------------------------------------------------------------------------------

devConfiguration :: PartialCardanoConfiguration
devConfiguration =
  PartialCardanoConfiguration
    { pccLogPath             = pure "./logs/"
    , pccDBPath              = pure "./db/"
    , pccLogConfig           = pure "./log-config.yaml"
    , pccApplicationLockFile = pure ""
    , pccCore                = pure
      PartialCore
        { pcoGenesis  =
          pure PartialGenesis
            { pgeSrc             = pure "testnet-genesis.json"
            , pgeGenesisHash     = pure "7f141ea26e189c9cb09e2473f6499561011d5d3c90dd642fde859ce02282a3ae"
            }
        , pcoStaticKeyMaterial =
          pure PartialStaticKeyMaterial
            { pskmSigningKeyFile = mempty
            , pskmDlgCertFile    = mempty
            }
        , pcoRequiresNetworkMagic = pure RequireNetworkMagic
        , pcoDBSerializeVersion   = pure 0
        }
    , pccNTP                 = pure
         NTP
          { ntpResponseTimeout = 30000000
          , ntpPollDelay       = 1800000000
          , ntpServers         =
            [ "0.pool.ntp.org"
            , "2.pool.ntp.org"
            , "3.pool.ntp.org"
            ]
          }
    , pccUpdate              = pure
        Update
          { upApplicationName       = "cardano-sl"
          , upApplicationVersion    = 0
          , upLastKnownBlockVersion =
            LastKnownBlockVersion
              { lkbvMajor = 0
              , lkbvMinor = 0
              , lkbvAlt   = 0
              }
                                               }
    , pccTXP                 = pure
        TXP
          { txpMemPoolLimitTx = 200
          , txpAssetLockedSrcAddress = []
          }
    , pccSSC                 = pure
        SSC
          { sscMPCSendInterval = 10
          , sscMdNoCommitmentsEpochThreshold = 3
          , sscNoReportNoSecretsForEpoch1    = False
          }
    , pccDLG                 = pure
        DLG
          { dlgCacheParam          = 500
          , dlgMessageCacheTimeout = 30
          }
    , pccBlock               = pure
        PartialBlock
          { pblNetworkDiameter        = pure 3
          , pblRecoveryHeadersMessage = pure 20
          , pblStreamWindow           = pure 2048
          , pblNonCriticalCQBootstrap = pure 0.95
          , pblNonCriticalCQ          = pure 0.8
          , pblCriticalCQBootstrap    = pure 0.8888
          , pblCriticalCQ             = pure 0.654321
          , pblCriticalForkThreshold  = pure 2
          , pblFixedTimeCQ            = pure 10
          }
    , pccNode                = pure
        PartialNode
          { pnoNetworkConnectionTimeout     = pure 15000
          , pnoConversationEstablishTimeout = pure 30000
          , pnoBlockRetrievalQueueSize      = pure 100
          , pnoPendingTxResubmissionPeriod  = pure 7
          , pnoWalletProductionApi          = pure False
          , pnoWalletTxCreationDisabled     = pure False
          , pnoExplorerExtendedApi          = pure False
          }
    , pccTLS =
        pure PartialTLS
          { ptlsCA =
              pure PartialCertificate
                { pcertOrganization = pure "Input Output HK"
                , pcertCommonName   = pure "Cardano SL Self-Signed Root CA"
                , pcertExpiryDays   = pure 3650
                , pcertAltDNS       = pure []
                }
          , ptlsServer =
              pure PartialCertificate
                { pcertOrganization = pure "Input Output HK"
                , pcertCommonName   = pure "Cardano SL Server Node"
                , pcertExpiryDays   = pure 365
                , pcertAltDNS       = pure
                    [ "localhost"
                    , "localhost.localdomain"
                    , "127.0.0.1"
                    , "::1"
                    ]
                }
          , ptlsClients =
              pure PartialCertificate
                { pcertOrganization = pure "Input Output HK"
                , pcertCommonName   = pure "Daedalus Wallet"
                , pcertExpiryDays   = pure 365
                , pcertAltDNS       = pure []
                }
          }
    , pccWallet =
        pure PartialWallet
          { pwaThrottle =
            pure PartialThrottle
              { pthEnabled = pure False
              , pthRate    = pure 0
              , pthPeriod  = pure ""
              , pthBurst   = pure 0
              }
          }
    }

