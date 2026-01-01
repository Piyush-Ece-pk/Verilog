import numpy as np
from sklearn.linear_model import LogisticRegression

N = 5000
accel = np.random.normal(0,10,N)
jerk  = np.random.normal(0,8,N)
steer = np.random.normal(0,5,N)
brake = np.random.normal(0,12,N)

X = np.column_stack([accel, jerk, steer, brake])

y = (np.abs(accel)+np.abs(jerk)+brake > 50).astype(int)

model = LogisticRegression()
model.fit(X, y)

print(model.coef_)
