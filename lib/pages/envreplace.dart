class EnvReplace {
   static String localhost = "http://localhost:8545"; // 与hardhat.config.js中的url保持一致 注意端口号
   static String websocket = "ws://localhost:8545"; // 与hardhat.config.js中的url保持一致
   // 这个表示钱包的私钥，请替换成你自己的私钥 这里用的是 npx hardhat node 的第一个账号的地址
   // await walletService.savePrivateKey(
   // '0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80',
   // );
   // 这里用的是 npx hardhat node 的第一个账号的地址  捞的一个私钥 切记不要用自己的私钥正式环境下操作的时候
    static String privateKey = '0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80';

    //delopedcontract的地址         //这是npx hardhat run scripts/deployVoting.ts --network localhost 部署的地址
   static  String  delployedContractAddress = "0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512";




}