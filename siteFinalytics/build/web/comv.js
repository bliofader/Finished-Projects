const apiKey = '9772748ce7bf30cb48274555'; // Sua chave da API
const apiUrl = `https://v6.exchangerate-api.com/v6/${apiKey}/latest/USD`;

const converterForm = document.getElementById('converterForm');
const fromCurrency = document.getElementById('fromCurrency');
const toCurrency = document.getElementById('toCurrency');
const result = document.getElementById('result');

// Função para buscar e popular as moedas
async function fetchCurrencies() {
    try {
        const response = await fetch(apiUrl);
        const data = await response.json();
        const currencies = Object.keys(data.conversion_rates);

        currencies.forEach(currency => {
            const option1 = document.createElement('option');
            option1.value = currency;
            option1.textContent = currency;
            fromCurrency.appendChild(option1);

            const option2 = document.createElement('option');
            option2.value = currency;
            option2.textContent = currency;
            toCurrency.appendChild(option2);
        });
    } catch (error) {
        console.error('Erro ao carregar as moedas:', error);
    }
}

// Função para converter a moeda
async function convertCurrency(event) {
    event.preventDefault();

    const amount = document.getElementById('amount').value;
    const from = fromCurrency.value;
    const to = toCurrency.value;

    try {
        const response = await fetch(`https://v6.exchangerate-api.com/v6/${apiKey}/pair/${from}/${to}`);
        const data = await response.json();
        const exchangeRate = data.conversion_rate;
        const convertedAmount = amount * exchangeRate;

        result.textContent = `${amount} ${from} equivale a ${convertedAmount.toFixed(2)} ${to}`;
    } catch (error) {
        console.error('Erro ao converter moeda:', error);
        result.textContent = 'Ocorreu um erro ao converter moeda. Por favor, tente novamente.';
    }
}

converterForm.addEventListener('submit', convertCurrency);

fetchCurrencies();
