# Inventory Analysis Project

## Navigation
- [User Story](#user-story-inventory-insights)
- [Data Collection](#data-collection)
- [Data Cleaning](#data-cleaning)
- [Data Analysis and Visualizations](#data-analysis-and-visualizations)
- [Actionable Recommendations](#actionable-recommendations)

## User Story: Inventory Insights

A retail company specializing in office supplies, technology products, and furniture seeks to gain a deeper understanding of its inventory and demand. The management team aims to uncover specific insights across their three key departments to inform decision-making and guide future strategies.

Key Business Questions:

  * Which products drive the majority of sales and should be prioritized for stock replenishment?
  * Which items have low sales and may be candidates for discontinuation or promotional strategies?
  * What are the projected demand trends by month or season to optimize stock levels?

## Business Objectives

  * Analyze products based on revenue impact, helping prioritize inventory decisions.
  * Forecast future demand to anticipate stock needs and reduce the risk of stockouts during peak periods.
  * Provide actionable recommendations on inventory optimization and product recommendations 

## Data Collection
The dataset includes four CSV files: Orders, Customers, Products, and Location. The Orders file details transactions over five years (2018–2023). The Customers file contains customer information such as location and name, while the Products file lists all SKUs the company currently offers. The Location file includes address information within the United States.

## Data Cleaning

The dataset required processing and cleaning to ensure quality, focusing on:

  * Correcting text/spelling errors.
  * Standardizing labels, formats, and field lengths.
  * Removing duplicates.
  * Handling missing or blank values.

Data integrity is crucial to accurate analysis. The complete data cleaning process is documented in the data cleaning file attached. Also see my [SQL script](https://github.com/Carlos081023/Carlos_Portfolio2/blob/main/Portfolio%20Project%202%20-%20Inventory%20Analysis%20Code.sql) for additonal cleaning done.

## Data Analysis and Visualizations

### Exploratory Data Analysis

Please see my full [SQL script](https://github.com/Carlos081023/Carlos_Portfolio2/blob/main/Portfolio%20Project%202%20-%20Inventory%20Analysis%20Code.sql) is here to view all queries.

#### Top/Bottom 10 Products by Sales

##### Top
![image alt](https://github.com/Carlos081023/Carlos_Portfolio2/blob/838fd0f8f66b324a3537f91e183d9baf276e7ce8/Screenshot%202024-11-08%20194002.png)

##### Bottom 
![image alt](https://github.com/Carlos081023/Carlos_Portfolio2/blob/838fd0f8f66b324a3537f91e183d9baf276e7ce8/Screenshot%202024-11-08%20194053.png)

Identifying the most and least popular products provides valuable insight into consumer preferences and key revenue drivers, enabling the company to optimize inventory management to meet customer demand effectively. The top-selling products are Copiers, Binders, and Machines—have collectively generated $261,450 in sales.

Conversely, the bottom ten products are primarily office supplies. Notably, the Sauder Forest Hills Bookcase has no reported sales, indicating a potential absence of sales data. This NULL value warrants careful examination to ensure accurate data interpretation and informed inventory decisions.

#### Top/Bottom 3 Products from each Category and Year by Sales

##### Top
![image alt](https://github.com/Carlos081023/Carlos_Portfolio2/blob/b71329d51b2c73035f893eb5e71075bdd7cdeadf/Screenshot%202024-11-08%20182153.png)

##### Bottom 
![image alt](https://github.com/Carlos081023/Carlos_Portfolio2/blob/d41683e5c88a783c650d75d24637dc4058cb5584/Screenshot%202024-11-08%20195319.png)

Top/Bottom 3 products by each year and category by total sales provide a much more detailed view into changing consumer tastes and product performance that can be used for optimizing inventory. 

For Furniture, consumer demand for the types of products varied between Chairs, Tables, and Bookcases. Recently, since 2022, consumer demand has shifted towards chair products and product FUR-CH-10001215 has been among the top three products since 2022. 

Conversely, furnishing items have consistently been the least popular choice for consumers. Product FUR-FU-10003274 has been among the least performing products since 2020 with meager sales. 

For Technology, consumer demand has revolved around Copiers, Machines, and Accessories. Among these Sub-Categories, product TEC-MA-10001127 and TEC-CO-10004722 were among top consumer choices for 2 years each.

Conversely, Accessories items have consistently been the least popular choice for consumers. Product TEC-AC-10002370 has been among the least performing products since 2020.

For Office Supplies, consumer demand concentrates heavily in Binders. Since 2020, Binder products have been a strong consumer choice thus making sure inventory for these items is readily available for consumers to purchase.

Binders items have also consistently been the least popular choice for consumers. Product demand for these items are poor and must evaluate a course action into options to reduce inventory in these products to avoid unneccesary holding costs.

#### Top/Bottom 10 Products by Number of Purchases

##### Top
![image alt](https://github.com/Carlos081023/Carlos_Portfolio2/blob/b71329d51b2c73035f893eb5e71075bdd7cdeadf/Screenshot%202024-11-08%20195402.png)

##### Bottom 
![image alt](https://github.com/Carlos081023/Carlos_Portfolio2/blob/b71329d51b2c73035f893eb5e71075bdd7cdeadf/Screenshot%202024-11-08%20195438.png)

Looking into Top/Bottom products by Number of Purchases can help us to understand what items are a popular choice among consumers and evaluating demand to optimize inventory. While sales for the top and bottom products may vary, identifying these products can help to improve inventory processes and reduce holding costs by identifying items that are not moving as much.

### ABC Analysis

#### What is ABC Analysis?
ABC Analyis is a method of inventory classification method that will identify products based on a measure of importance to allocate control efforts accordingly. 

* A products are high importance
* B products are medium importance
* C products are least importance

Generally, A items account for the largest dollar value but relatively small percentage of total items. For example, About 5-15% of the SKUs or items account for 60-80% of the total dollar value. B items account for a medium or moderate dollar value. B items are about 30% of the SKUs with about 15% dollar value. C items account for the highest percentage of SKUs but a relatively low percerntage of total dollar value.

![image alt](https://github.com/Carlos081023/Carlos_Portfolio2/blob/9f70e8f2f217c0ec2f061c7e4718446f02fec137/Screenshot%202024-11-08%20180849.png)

For this ABC Analysis, 10% of the total number of SKUs are A products, 25% are B products, and 65% of items are C products. After identifying products and assigining classifications here are some insights we can gather to help optimize inventory.

* There are 193 A items that account for a 1.3 million dollar value
* There are 460 B items that account for a 690k dollar value
* There are 1209 C items that account for a 230k dollar value

Using this ABC Analysis, SKUs that categorized as A are of the utmost importance to the success of the business and inventory needs must be met to meet the demand. B items must maintain a inventory management strategy to ensure inventory does not sit too long to avoid holding/costs. C items are the bulk of our inventory holding cost because they will tend to sit longer. 

While C items are still essential to meet customer needs, strategies like discounts or targeted promotions can help move these items more quickly. Additionally, selective discontinuation of underperforming "C" items can yield cost savings.

#### Discontinuing Certain C Items
To further optimize inventory, certain C items may be discontinued based on specific criteria:

* Criteria: Products with less than $350 in total sales and negative profits are candidates for removal.

![image alt](https://github.com/Carlos081023/Carlos_Portfolio2/blob/e75e3746d9d19045445cef7f1db015fcd9389aea/Screenshot%202024-11-09%20204538.png)

The impact of discontinuing these items will result:

* Increase profit by 1.2%
* Decrease costs by .9%
* Remove 113 items from the C items

Eliminating these items improves profitability and streamlines inventory management, reducing the need for future ordering and associated holding costs. This approach optimizes resources, focusing on products that add greater value to the business.

### Demand Forecast
![image alt](https://github.com/Carlos081023/Carlos_Portfolio2/blob/e75e3746d9d19045445cef7f1db015fcd9389aea/Screenshot%202024-11-09%20211628.png)

Demand over time trendline has very evident seasonality to it. Demand peaks in Fall months, more specifically September and Novemeber, consistently over the four year period of 2020-2023. Understanding this will be essential to creating an accurate and reliable demand forecast.



#### Yearly Demand Regression Line
![image alt](https://github.com/Carlos081023/Carlos_Portfolio2/blob/530605a4fb8a1e85a4a5e02a6807fa93f280b2d8/Screenshot%202024-11-08%20200301.png)

To forecast demand accurately over the next 12 months, we first need an annual demand estimate. I used simple linear regression on yearly demand data to predict next year’s demand. The regression line was chosen based on an R-squared value of 0.91, meaning 91% of the variation in demand can be explained by the yearly trend, which provides a solid foundation for prediction.

Linear Regression Equation:   Demand = 1654.3x+5332.5
   
Where:
* y is the predicted demand for year x.
* x is the year

Using this yearly demand forecast as a baseline allows us to account for general demand growth or decline while incorporating seasonality for more precise monthly projections.

#### What is a Seasonal Index? 
A Seasonal Index adjusts for monthly (or other period) fluctuations. I calculated a seasonal index for each month based on historical data, comparing each month’s demand to the average monthly demand over the entire period.

This index can tell us:
* Index > 1 indicates higher-than-average demand, signaling peak months.
* Index < 1 indicates lower-than-average demand, signaling off-peak months.
  
![image alt](https://github.com/Carlos081023/Carlos_Portfolio2/blob/530605a4fb8a1e85a4a5e02a6807fa93f280b2d8/Screenshot%202024-11-08%20200346.png)

With the baseline demand of 13604 and the Seasonal Index for each month, I created a seasonal demand forecast for the next 12 months. This approach allows inventory and operations to anticipate demand more accurately by:

* Increasing inventory in peak months, when demand is expected to be higher.
* Reducing inventory in off-peak months to avoid overstocking.
  
This combined method of trend-based prediction and seasonality adjustment helps balance inventory levels, ensuring better preparedness for demand fluctuations throughout the year.

## Actionable Recommendations:

* Discontinuing some C products: By discontinuing C items with poor sales and produce negative profits, we can effectively reduce costs by .9% and improve profits by 1.2%.
* Monitor and balance inventory stock for A and B items: By maintaining a close watch on top drivers for sales as well as items that have a moderate demand, it will ensure inventory for A items is readily avaiable and well stocked for customers and B items inventory maintained to avoid overstocking to keep associated costs to a minimium.
  
  
