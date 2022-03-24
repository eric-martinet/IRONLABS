import streamlit as st
import pandas as pd
import numpy as np
from sklearn.datasets import load_breast_cancer
import matplotlib.pyplot as plt
import seaborn as sns

breast_cancer = load_breast_cancer(as_frame=True)
breast_cancer_df = pd.concat((breast_cancer["data"], breast_cancer["target"]), axis=1)
breast_cancer_df["target"] = [breast_cancer.target_names[val] for val in breast_cancer_df["target"]]

malignant_df = breast_cancer_df[breast_cancer_df["target"] == "malignant"]
benign_df = breast_cancer_df[breast_cancer_df["target"] == "benign"]

measurements = breast_cancer_df.columns.to_list()
measurements.remove('target')


# Global layout
st.set_page_config(layout="wide")
st.markdown('# Breast Cancer Stats')
figsize = (6,4)

default_cols = ["mean smoothness","mean compactness"]


# Scatter chart with dropdown
st.sidebar.markdown('### Dropdown with Scatter chart')


x_axis_scatter = st.sidebar.selectbox('X axis', measurements, index = measurements.index(default_cols[0]))
y_axis_scatter = st.sidebar.selectbox('Y axis', measurements, index = measurements.index(default_cols[1]))

fig_scatter = plt.figure(figsize=figsize)
ax_scatter = fig_scatter.add_subplot(1,1,1)

if x_axis_scatter and y_axis_scatter:
    malignant_df.plot.scatter(x=x_axis_scatter, y=y_axis_scatter, s=120, c="tomato", alpha=0.6, ax=ax_scatter, label="Malignant")
    benign_df.plot.scatter(x=x_axis_scatter, y=y_axis_scatter, s=120, c="dodgerblue", alpha=0.6, ax=ax_scatter, label="Benign")
else:
    malignant_df.plot.scatter(x=default_cols[0], y=default_cols[1], s=120, c="tomato", alpha=0.6, ax=ax_scatter, label="Malignant")
    benign_df.plot.scatter(x=default_cols[0], y=default_cols[1], s=120, c="dodgerblue", alpha=0.6, ax=ax_scatter, label="Benign")

ax_scatter.set_title(x_axis_scatter.title() + ' vs. ' + y_axis_scatter.title() + ' per Tumor Type')
ax_scatter.set_xlabel(x_axis_scatter.title())
ax_scatter.set_ylabel(y_axis_scatter.title())

#st.write(fig_scatter)


# Bar chart with Multiselect
st.sidebar.markdown('### Bar chart with Multiselect')

l_select_bar = st.sidebar.multiselect('Measurements', measurements, key = 'bar', default = default_cols)

if l_select_bar:
    breast_cancer_df_subset_bar = breast_cancer_df.groupby('target').mean().loc[:,l_select_bar]
else:
    breast_cancer_df_subset_bar = breast_cancer_df.groupby('target').mean().loc[:,default_cols]

fig_bar = plt.figure(figsize=figsize)
ax_bar = fig_bar.add_subplot(1,1,1)
breast_cancer_df_subset_bar.plot.bar(ax=ax_bar, cmap = "Set1")
ax_bar.set_title("Average Measurements per Tumor Type")
ax_bar.set_xlabel('Tumor Type')
 
#st.write(fig_bar)


# Histogram Chart with Multiselect & Radio buttons
st.sidebar.markdown('### Histogram Chart with Multiselect & Radio buttons')
l_select_hist = st.sidebar.multiselect('Measurements', measurements, key = 'hist', default = default_cols)

nb_bin_hist = st.sidebar.radio('Number of bins',options = [5, 10, 50, 100], index = 2)

fig_hist = plt.figure(figsize=figsize)
ax_hist = fig_hist.add_subplot(1,1,1)

if l_select_hist and nb_bin_hist:
    breast_cancer_df_subset_hist = breast_cancer_df.loc[:,l_select_hist]
else:
    breast_cancer_df_subset_hist = breast_cancer_df.loc[:,default_cols]

breast_cancer_df_subset_hist.plot.hist(bins=nb_bin_hist, alpha = 0.75, ax=ax_hist, cmap = "Set1")
ax_hist.set_title("Distribution of Measurements")

#st.write(fig_hist)


# Hexbin Chart with Multiselects
st.sidebar.markdown('### Hexbin Chart with Multiselects')

x_axis_hexbin = st.sidebar.selectbox("X axis", measurements, index = 0, key = 'hexbin_x')
y_axis_hexbin = st.sidebar.selectbox("Y axis", measurements, index = 1, key = 'hexbin_y')

 
fig_hexbin = plt.figure(figsize=figsize)
ax_hexbin = fig_hexbin.add_subplot(111)

breast_cancer_df.plot.hexbin(x=x_axis_hexbin, y=y_axis_hexbin, reduce_C_function=np.mean, gridsize=25, ax = ax_hexbin) 

ax_hexbin.set_title("Concentration of Measurements")
ax_hexbin.set_xlabel(x_axis_hexbin.title())
ax_hexbin.set_ylabel(y_axis_hexbin.title())

#st.write(fig_hexbin)


# Layout Application

container1 = st.container()
col1, col2 = st.columns(2)

with container1:
    with col1:
        st.write(fig_scatter)
    with col2:
        st.write(fig_bar)


container2 = st.container()
col3, col4 = st.columns(2)

with container2:
    with col3:
        st.write(fig_hist)
    with col4:
        st.write(fig_hexbin)