from dataclasses import dataclass
from typing import List

@dataclass
class Snapshot:
    ticker: str
    time: int
    value: int

@dataclass 
class SnapPick:
    upper: Snapshot
    lower: Snapshot

    def value(self):
        return self.upper.value - self.lower.value

def single_max_pick(snapshots: list[Snapshot]):
    snapshots_for_ticker = {}

    for snap in snapshots:
        snapshots_for_ticker.setdefault(snap.ticker, []).append(snap)

    all_picks: List[SnapPick] = []

    for ticker_snaps in snapshots_for_ticker.values():
        def sort_fn(item: Snapshot):
            item.time

        ticker_snaps.sort(key=sort_fn)

        min_ticker = ticker_snaps[0]

        snap_pick = SnapPick(upper=min_ticker, lower=min_ticker)

        for snap in ticker_snaps:
            if snap.value < min_ticker.value:
                min_ticker = snap
            
            if snap.value - min_ticker.value > snap_pick.value:
                snap_pick = SnapPick(upper=snap, lower=min_ticker)

        all_picks.append(snap_pick)

    return max(all_picks, key=lambda x: x.value)

                

            
