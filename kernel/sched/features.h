/*
 * Only give sleepers 50% of their service deficit. This allows
 * them to run sooner, but does not allow tons of sleepers to
 * rip the spread apart.
 */
SCHED_FEAT(GENTLE_FAIR_SLEEPERS, true)

/*
 * Place new tasks ahead so that they do not starve already running
 * tasks
 */
SCHED_FEAT(START_DEBIT, true)

/*
 * Based on load and program behaviour, see if it makes sense to place
 * a newly woken task on the same cpu as the task that woke it --
 * improve cache locality. Typically used with SYNC wakeups as
 * generated by pipes and the like, see also SYNC_WAKEUPS.
 */
SCHED_FEAT(AFFINE_WAKEUPS, true)

/*
 * Prefer to schedule the task we woke last (assuming it failed
 * wakeup-preemption), since its likely going to consume data we
 * touched, increases cache locality.
 */
SCHED_FEAT(NEXT_BUDDY, true)

/*
 * Prefer to schedule the task that ran last (when we did
 * wake-preempt) as that likely will touch the same data, increases
 * cache locality.
 */
SCHED_FEAT(LAST_BUDDY, true)

/*
 * Consider buddies to be cache hot, decreases the likelyness of a
 * cache buddy being migrated away, increases cache locality.
 */
SCHED_FEAT(CACHE_HOT_BUDDY, true)

/*
 * Use arch dependent cpu power functions
 */
SCHED_FEAT(ARCH_POWER, true)

SCHED_FEAT(HRTICK, true)
SCHED_FEAT(DOUBLE_TICK, true)
SCHED_FEAT(LB_BIAS, true)

/*
 * Spin-wait on mutex acquisition when the mutex owner is running on
 * another cpu -- assumes that when the owner is running, it will soon
 * release the lock. Decreases scheduling overhead.
 */
SCHED_FEAT(OWNER_SPIN, true)

/*
 * Decrement CPU power based on time not spent running tasks
 */
SCHED_FEAT(NONTASK_POWER, true)

/*
 * Queue remote wakeups on the target CPU and process them
 * using the scheduler IPI. Reduces rq->lock contention/bounces.
 */
SCHED_FEAT(TTWU_QUEUE, true)

SCHED_FEAT(FORCE_SD_OVERLAP, true)
SCHED_FEAT(RT_RUNTIME_SHARE, true)
SCHED_FEAT(LB_MIN, true)
