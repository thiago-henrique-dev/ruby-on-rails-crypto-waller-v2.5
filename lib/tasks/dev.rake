namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do 
    if Rails.env.development?
      show_spinner("Excluindo Banco de Dados"){ %x(rails db:drop) }
      show_spinner("Criando Banco de Dados"){ %x(rails db:create) }
      show_spinner("Migrando as Tabelas"){%x(rails db:migrate)}
       %x(rails dev:add_coins)
       %x(rails dev:add_mining_types)
    else
      puts "Você não está em ambiente de desenvolvimento!"
    end
  end


  desc "Cadastra as moedas"
  task add_coins: :environment do
    show_spinner("Cadastrando Moedas...") do
      coins = [
                { 
                  description: "Bitcoin",
                  acronym: "BTC",
                  url_image: "https://assets.chinatechnews.com/wp-content/uploads/bitcoin-logo.jpg",
                
                },
                { 
                  description: "Ethereum",
                  acronym: "ETH",
                  url_image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQZCRfwkqpPvFb3QmmwGONG2i6PsgnqZ3L7dRzCNlaSTB1-ruu5",
          
                },
                { 
                  description: "Dash",
                  acronym: "DASH",
                  url_image: "https://ih1.redbubble.net/image.406055498.8711/ap,550x550,12x12,1,transparent,t.png",
   
                },
                { 
                  description: "Iota",
                  acronym: "IOT",
                  url_image: "https://s2.coinmarketcap.com/static/img/coins/200x200/1720.png",
         
                },
                { 
                  description: "ZCash",
                  acronym: "ZEC",
                  url_image: "https://www.cryptocompare.com/media/351360/zec.png",
            
                }
              ]

  coins.each do |coin|
      Coin.find_or_create_by!(coin)
     end
    end
  end

 desc "Cadastro dos tipos de mineração"
 task add_mining_types: :environment do
  show_spinner("Cadastrando Moedas") do
  mining_types = [
    {
      name:"Proof of Work", 
      acronym: "PoW",
    },
    {
      name:"Proof of Stake",
      acronym: "PoS",
    },
    {
      name: "Proof of Capacity",
      acronym: "PoW",
    },
  ]

  mining_types.each do |mining_type|
    MiningType.find_or_create_by!(mining_type)
  end
 end
end       

  private
  def show_spinner(msg_start, msg_end = "Concluido")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")  
    spinner.auto_spin   
    yield
    spinner.success("(#{msg_end})")
  end

end

