import React, { useEffect, useState } from 'react';
import '../style/Reports.scss';
import { Doughnut, Bar, Line } from 'react-chartjs-2';

function ReportsPage(props) {
  let[loading, setLoading] = useState(true);
  let[salesByGenre, setSalesByGenre] = useState([]);
  let[salesByAuthor, setSalesByAuthor] = useState([]);
  let[priceVsExpenditure, setPriceVsExpenditure] = useState([]);
  

  const getSalesByGenre = async () => {
    let response = await fetch(`http://localhost:8080/books/salesbygenre`);
    let data = await response.json()
    setSalesByGenre(data);

    getSalesByAuthor();
  }

  const getSalesByAuthor = async () => {
    let response = await fetch(`http://localhost:8080/books/salesbyauthor`);
    let data = await response.json()
    setSalesByAuthor(data);
    
    getPriceVsExpenditure();

    
  }

  const getPriceVsExpenditure = async () => {
    let response = await fetch(`http://localhost:8080/books/getpricevsexpenditure`);
    let data = await response.json()
    setPriceVsExpenditure(data);

    setLoading(false);
  }

  useEffect(() => {
    if(loading){
        getSalesByGenre()
    }
  },[loading]);

  const generateColor = () => {
    return '#' +  Math.random().toString(16).substr(-6);
  }  

  const chartOptions = () =>{
    var options = {
        scales: {
            xAxes: [{ stacked: true }],
            yAxes: [{
              stacked: false,
              ticks: {
                beginAtZero: true,
              },
            }]
        },
        legend: {
            display: false,
        },
    };
    
    return options;
}

const priceVsExpenditureChart =(data)=>{

    let bar = {
        labels: [], //names	
        datasets: [
            {
                label: 'Expenditure',
                data: [],
                backgroundColor: '#FF4500',
                borderWidth: 1,
            },
            {
                label: 'Price',
                data: [],
                backgroundColor: '#6495ED',
                borderWidth: 1,
            }
        ]
      }; 

      if(data!=null){
          let chartData = data
          
          for(let i=0;i<chartData.length;i++){

              bar.labels.push(chartData[i].Book_title);
              bar.datasets[0].data.push(chartData[i].Expenditure);
              bar.datasets[1].data.push(chartData[i].Book_price);
          }
      }

      return bar;
}
const salesByAuthorPie = (data) =>{

    const colorList = ['#e6194b', '#3cb44b', '#ffe119', '#4363d8', '#f58231', '#911eb4', '#46f0f0', '#f032e6', '#bcf60c', '#fabebe', '#008080', '#e6beff', '#9a6324', '#fffac8', '#800000', '#aaffc3', '#808000', '#ffd8b1', '#000075', '#808080', '#ffffff', '#000000']

    const donut = {
        labels: [
            
        ],
        datasets: [{
            data: [],
            backgroundColor: [
            
            ],
            hoverBackgroundColor: [
            
            ]
        }]
    };

    if(data != null){
        let chartData = data;	
        let genres = [];
        let labels = [];
        let colors = [];
        console.log(chartData)
        for(let i=0; i<chartData.length;i++){
            console.log(chartData[i])
            genres.push(chartData[i].First_name+" "+chartData[i].Last_name)
            labels.push(chartData[i].Count)
            colors.push(generateColor());//colorList[i]);
        }

        donut.labels = genres;
        donut.datasets[0].data = labels;
        donut.datasets[0].backgroundColor = colors;

    }
    return donut
  }

  const salesByGenrePie = (data) =>{

    const colorList = ['#e6194b', '#3cb44b', '#ffe119', '#4363d8', '#f58231', '#911eb4', '#46f0f0', '#f032e6', '#bcf60c', '#fabebe', '#008080', '#e6beff', '#9a6324', '#fffac8', '#800000', '#aaffc3', '#808000', '#ffd8b1', '#000075', '#808080', '#ffffff', '#000000']

    const donut = {
        labels: [
            
        ],
        datasets: [{
            data: [],
            backgroundColor: [
            
            ],
            hoverBackgroundColor: [
            
            ]
        }]
    };

    if(data != null){
        let chartData = data;	
        let genres = [];
        let labels = [];
        let colors = [];
  
        for(let i=0; i<chartData.length;i++){
            
            genres.push(chartData[i].Book_genre)
            labels.push(chartData[i].Count)
            colors.push(generateColor());//colorList[i]);
        }

        donut.labels = genres;
        donut.datasets[0].data = labels;
        donut.datasets[0].backgroundColor = colors;

    }

    return donut
  }

  const chartStyleBase = {
    margin: "auto",
    width: "50%"
  };

  return (
    <div className="reports">
        { !loading && salesByGenre != [] &&
            <>
            <div style={{"margin":"auto", "textAlign":"center"}}><h2>Sales per Genre</h2></div>
            <br></br>
            <div class="graph-row">
                <div style={{...chartStyleBase}}><Doughnut data={salesByGenrePie(salesByGenre)} /></div>
                <div style={{...chartStyleBase}}><Bar data={salesByGenrePie(salesByGenre)} options={chartOptions()}/></div>
            </div>
            <div style={{"margin":"auto", "textAlign":"center"}}><h2>Sales per Author</h2></div>
            <br></br>
            <div class="graph-row">
                <div style={{...chartStyleBase}}><Doughnut data={salesByAuthorPie(salesByAuthor)} /></div>
                <div style={{...chartStyleBase}}><Bar data={salesByAuthorPie(salesByAuthor)} options={chartOptions()}/></div>
            </div>
            <div style={{"margin":"auto", "textAlign":"center"}}><h2>Price vs. Expenditure</h2></div>
            <br></br>
            <div class="graph-row">
                <div style={{"width" : "70%", "margin":"auto"}}><Bar data={priceVsExpenditureChart(priceVsExpenditure)} options={chartOptions()}/></div>
            </div>
            </>
        }
    </div>
  );
}

export default ReportsPage;
