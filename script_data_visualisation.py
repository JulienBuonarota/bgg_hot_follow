import pandas as pd
import psycopg2
import matplotlib.pyplot as plt
import matplotlib.dates as dates
import scipy.interpolate as sci
import numpy as np

## Get data of specific game
bgg_game_id = 101

with psycopg2.connect("dbname=BGGDB user=bgg password=admin host=localhost") as conn:
    with conn.cursor() as cur:
        cur.execute("""
			SELECT *
			FROM bgg_hotness_record
			WHERE %s = ANY (hotness_list);""",
        (bgg_game_id,))
        data = cur.fetchall()

data = pd.DataFrame(data, columns=['id', 'timestamp', 'hotness_list'])


## compute game position in hotness list
data['rank'] = data['hotness_list'].apply(lambda x: x.index(bgg_game_id))

## PLOT
x = data[['timestamp']].to_numpy().squeeze()
y = data[['rank']].to_numpy().squeeze() + 1

# CURVE INTERPOLATION using epoch
x_epoch = np.array([int(i - np.datetime64("1970-01-01")) for i in x])
cubic_interploation_model = sci.interp1d(x_epoch, y, kind = "cubic")

X_ = np.linspace(int(x_epoch.min()), int(x_epoch.max()), 500)
Y_ = cubic_interploation_model(X_)
# for ploting using matplotlib date tools
X_timestamp = np.array(X_, dtype='datetime64[ns]')

## plot
fig, ax = plt.subplots()
ax.plot(X_timestamp, Y_)
#ax.plot(x, y)

ax.invert_yaxis()

# ax.set_ylim(top=0)

ax.set_xlabel('x')
ax.set_ylabel('y')
ax.set_title('title')

ax.xaxis.set_major_locator(dates.DayLocator(interval=3))    # every 3 days
ax.xaxis.set_major_formatter(dates.DateFormatter('\n%d-%m-%Y')) 
plt.show()


    
