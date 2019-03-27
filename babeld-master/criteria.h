




#define MESSAGE_BATTERY 40
#define LENGTH_ALL_CRITERIA 3
#define LENGTH_CRITERIA_BATTERY 1



void push_criteria (struct buffered *buf);
void update_metric_battery_criteria (int *metric);
int is_battery_critical (int b);
void update_delay_neighbour_criteria (struct neighbour *neigh);
void update_metric_delay_criteria (short unsigned int *metric,
				   struct neighbour *neigh);
