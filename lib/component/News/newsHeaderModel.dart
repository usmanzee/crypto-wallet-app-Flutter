class NewsHeader {
  NewsHeader(
      {this.title,
      this.category,
      this.imageUrl,
      this.id,
      this.desc1,
      this.desc2,
      this.desc3});

  final String desc1, desc2, desc3;
  final String id;
  final String title;
  final String category;
  final String imageUrl;
}

final sampleItems = <NewsHeader>[
  new NewsHeader(
      title: 'Blockstream Aims to Help Exchanges to Prove their Reserves',
      category: 'By Tim Alper',
      imageUrl: 'assets/image/News_Image/BlockStream.jpg',
      desc1:
          "The Chicago Board Options Exchange (CBOE) has announced that its CFE futures exchange platform will not be adding a Bitcoin (XBT) futures contract this month. The exchange operator also says it is currently considering its future stance on cryptocurrency derivatives trading.\n\nAccording to an official release, the CFE operator stated, “The CFE is assessing its approach with respect to how it plans to continue to offer digital asset derivatives for trading. While it considers its next steps, the CFE does not currently intend to list additional XBT futures contracts for trading.”",
      desc2:
          "Rival CME exchange last month announced it had hit a new record of 18,338 bitcoin futures contracts traded, equivalent to around USD 360 million – although figures from March have been significantly lower.\n\nMeanwhile, the Unites States’ top financial regulator, the Securities and Exchange Commission (SEC), is still deliberating whether or not to approve a Bitcoin exchange-traded fund (ETF), and some claim the latest CBOE decision does not bode well in this regard. MisterLister lamented on Twitter, “ETF approval can’t be further away at this point.",
      desc3:
          "The exchange noted, however, that “currently listed XBT futures contracts remain available for trading” – meaning existing futures listed last month (XBTM19) will continue to run until June\n\nCryptocurrency enthusiasts on Twitter and Reddit speculated that low trading volumes and competitor success may have been contributing factors in the CBOE’s decision.\n\nRival CME exchange last month announced it had hit a new record of 18,338 bitcoin futures contracts traded, equivalent to around USD 360 million – although figures from March have been significantly lower.",
      id: '1'),
  new NewsHeader(
      title: 'Zilliqa Launches First Public Sharding Blockchain',
      category: 'By Sead Fadilpašić',
      imageUrl: 'assets/image/News_Image/Ziliqa.jpg',
      id: '2',
      desc1:
          "Although the classification of cryptocurrencies by their market capitalization is the simplest one (despite the fact that this metric has flaws,) you may have wondered how the cryptocurrencies would rank by the size of their respective communities on Twitter, especially when some of crypto stars are bragging about the number of their followers and buying ads to get more.",
      desc2:
          "1. Tron: Justin Sun - 896,000 followers\n\ncontract platform Ethereum. “Now we are both [at] 832k [followers]. We started six year [sic] after you but we always know it is never too late.”\n\n2. Ethereum: Vitalik Buterin - 837,000 followers\n\nAlthough Ethereum is striving to be as decentralized as possible, its political centralization is a sticking point for many, and Vitalik is by far the most recognized person involved in the smart contract platform. He is also often considered one of the biggest authorities on all things blockchain - given that he started Ethereum at the age of 19, the community’s trust in him is hardly misplaced.",
      desc3:
          "3. Bitcoin Cash: Roger Ver - 569,000 followers\n\nBitcoin Cash is yet another of those projects that has no real leader figure, but when you mention the name Roger Ver, chances are most people will ask you “Is that the Bitcoin Cash guy?” Well-known for his unmoving belief that Bitcoin Cash is the real vision of Bitcoin creator Satoshi Nakamoto, Ver’s opinions are often considered controversial - which is part of what makes him so popular.\n\n4. Bitcoin: Andreas M. Antonopoulos - 470,000 followers\n\nSelecting one single person to represent Bitcoin is hard. Nobody knows (at least we don't) who Satoshi Nakamoto is - so our choice was between Andreas M. Antonopoulos and Nick Szabo. Considering that the former is slightly more active and outspoken within the Bitcoin community, our choice fell on him. Best-known for his best-selling book Mastering Bitcoin, Antonopoulos is often the loudest voice in matters of decentralization."),
  new NewsHeader(
      title: 'This Crypto Brokerage to Make Money With Commission-free Trading',
      category: 'By Tim Alper',
      imageUrl: 'assets/image/News_Image/CryptoBroker.jpg',
      id: '3',
      desc1:
          "Major cryptocurrency exchange Binance released Binance Chain and DEX testnet for public testing today. BNB, the native token of the exchange, is up by more than 14% in the past 24 hours (UTC 08:40 AM) while other major coins show small gains or are in red. (Updates throughout the entire text.)\n\n Binance Chain is a new blockchain developed and released by Binance. Binance DEX is a high performance and user friendly platform built on top of Binance Chain, where users can create, issue and trade digital assets,the exchange announced in a blog post, adding that the Binance Chain Mainnet launch date will be announced at a later date.",
      desc2:
          "Crypto fund Multicoin Capital, who owns BNB in its portfolio, in a new analysis claims that BNB, is dramatically undervalued, primarily because it is a novel asset with properties that many investors do not yet fully appreciate.\n\nWhile the cryptoverse is discussing how decentralized Binance DEX is, Changpeng Zhao (CZ), CEO of Binance, during a livestream on the Ivan on Tech Youtube channel Wednesday morning said that this debate is less meaningful as, according to him, main things to discuss are security, ease of use and freedom.\n\nAlso, previously he also admitted that Binance will have a lot of influence over the Binance Chain (Binance DEX is running on this blockchain) network and the validators. Moreover, the CEO said that the listing fee on the new exchange will be probably close to USD 100,000.",
      desc3:
          "Some enthusiasts have taken this to mean that adoption is coming - while more extreme ones already see a bull run in the future. Although this may not mean anything, a small sign of endorsement is certainly good, especially with the recent rally.\n\nHowever, this feature is not available on Android phones yet, and there is no indication that it could become available any time soon. Also, not every Google keyboard on iPhone offers this possibility, as users from Scandinavian countries as well as France claimed on Twitter that they could not find the option. Additionally, some users complain that when they click the symbol, it turns into ₱, the symbol for the Philippine Peso - but it is possible that this is just a temporary glitch.\n\nHe goes on further to explain that less decentralized means that socially, we have a lot of influence - as people know that it’s called the Binance Chain and we’re one of the key contributors to the development of the technology."),
  new NewsHeader(
      title: 'We might have the best team spirit ever.',
      category: 'SPIRIT',
      imageUrl: 'assets/image/article1.jpg',
      id: '4',
      desc1:
          "In the cryptoverse, where we’re all looking for signs of increased adoption with bated breath, even the smallest things can bring hype. Today we have a new one - it seems that almost everyone in the cryptoland is checking their iPhones for the Bitcoin symbol.",
      desc2:
          "It looks like the Google keyboard on iPhones now has a Bitcoin sign when you long press the dollar sign, among all the other currencies. However, no one knows when exactly it was added and why Google's product is not available on Android phones.\n\nTo access it, make sure you’re using the Google keyboard, not just the default Apple one, and hold down the dollar symbol to see a pop up of several of the world’s major currency symbols. The Bitcoin symbol is located on the far left. Although the symbol shares some similarities with the Thai Baht currency, the Baht has a single line all the way through - as opposed to Bitcoin’s two lines at the top and bottom of the capital B.",
      desc3:
          "Some enthusiasts have taken this to mean that adoption is coming - while more extreme ones already see a bull run in the future. Although this may not mean anything, a small sign of endorsement is certainly good, especially with the recent rally.\n\nHowever, this feature is not available on Android phones yet, and there is no indication that it could become available any time soon. Also, not every Google keyboard on iPhone offers this possibility, as users from Scandinavian countries as well as France claimed on Twitter that they could not find the option. Additionally, some users complain that when they click the symbol, it turns into ₱, the symbol for the Philippine Peso - but it is possible that this is just a temporary glitch."),
];
