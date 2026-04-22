# ======================================
# FRAUD DETECTION - EDA (FINAL POLISHED)
# ======================================

import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

# -------------------------------
# GLOBAL PLOT SETTINGS
# -------------------------------
plt.rcParams['figure.figsize'] = (10,5)
plt.rcParams['axes.titlesize'] = 14
plt.rcParams['axes.labelsize'] = 12
sns.set_style("whitegrid")

# -------------------------------
# 1. Load Data
# -------------------------------
df = pd.read_csv(r"D:\vamshi\Projects\fraud_detection_data Project\Python\data\fraud_data.csv")

# -------------------------------
# 2. Clean Column Names
# -------------------------------
df.columns = df.columns.str.lower().str.replace(" ", "_")

# -------------------------------
# 3. Convert Target Column
# -------------------------------
df['is_fraud'] = df['is_fraud'].str.lower().map({'yes': 1, 'no': 0})

# -------------------------------
# 4. Basic Overview
# -------------------------------
print("\n📊 DATA SHAPE:", df.shape)
print("\n📌 COLUMNS:\n", df.columns.tolist())
print("\n📄 SAMPLE DATA:\n", df.head())

# -------------------------------
# 5. Missing Values
# -------------------------------
print("\n❗ MISSING VALUES:\n", df.isnull().sum())

# -------------------------------
# 6. Fraud Distribution
# -------------------------------
print("\n🚨 FRAUD DISTRIBUTION:\n", df['is_fraud'].value_counts())
print("\n🚨 FRAUD %:\n", df['is_fraud'].value_counts(normalize=True) * 100)

# -------------------------------
# 7. Fraud by City
# -------------------------------
fraud_city = df.groupby('city')['is_fraud'].mean().sort_values(ascending=False) * 100
print("\n🏙️ FRAUD % BY CITY:\n", fraud_city)

fraud_city.head(10).plot(kind='bar')
plt.title("Top 10 Cities by Fraud Rate")
plt.ylabel("Fraud %")
plt.xlabel("City")
plt.xticks(rotation=45)
plt.tight_layout()
plt.show()

# -------------------------------
# 8. Fraud by Payment Channel
# -------------------------------
fraud_payment = df.groupby('payment_channel')['is_fraud'].mean().sort_values(ascending=False) * 100
print("\n💳 FRAUD % BY PAYMENT CHANNEL:\n", fraud_payment)

fraud_payment.plot(kind='bar')
plt.title("Fraud Rate by Payment Channel")
plt.ylabel("Fraud %")
plt.xlabel("Payment Channel")
plt.xticks(rotation=45)
plt.tight_layout()
plt.show()

# -------------------------------
# 9. Transaction Amount Distribution
# -------------------------------
sns.histplot(df['transaction_amount'], bins=50)
plt.title("Transaction Amount Distribution")
plt.xlabel("Transaction Amount")
plt.ylabel("Frequency")
plt.tight_layout()
plt.show()

# -------------------------------
# 10. Fraud vs Transaction Amount
# -------------------------------
sns.boxplot(x='is_fraud', y='transaction_amount', data=df)
plt.title("Transaction Amount vs Fraud")
plt.xlabel("Fraud (0 = No, 1 = Yes)")
plt.ylabel("Transaction Amount")
plt.tight_layout()
plt.show()

# -------------------------------
# 11. Correlation Heatmap
# -------------------------------
corr = df.select_dtypes(include='number').corr()
sns.heatmap(corr, cmap='coolwarm')
plt.title("Feature Correlation Matrix")
plt.tight_layout()
plt.show()

# -------------------------------
# 12. Key Insights (Write your own after observing)
# -------------------------------
print("\n📌 KEY INSIGHTS:")
print("1. Identify cities with highest fraud %")
print("2. Check risky payment channels")
print("3. Compare fraud vs non-fraud transaction amounts")
print("4. Observe correlation with risk_score, ip_risk_score")

print("\n✅ EDA COMPLETED SUCCESSFULLY")