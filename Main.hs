{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE TypeOperators #-}

module Main where

import Data.Aeson
import Data.Proxy
import GHC.Generics
import Network.HTTP.Client (newManager, defaultManagerSettings)
import Servant.API
import Servant.Client

newtype Ip = Ip {
  ip :: String
} deriving (Eq, Show, Generic)
instance FromJSON Ip
instance ToJSON Ip

type IPifyAPI = QueryParam "format" String :> Get '[JSON] Ip

ipifyAPI :: Proxy IPifyAPI
ipifyAPI = Proxy

-- query ?format=json
ipq :: ClientM Ip
ipq = client ipifyAPI (Just "json")

main :: IO ()
main = do
  manager' <- newManager defaultManagerSettings
  r <- runClientM ipq (mkClientEnv manager' (BaseUrl Http "api.ipify.org" 80 ""))
  case r of
    Left e -> putStrLn $ "Error: " <> show e
    Right (Ip ip) -> putStrLn ip
