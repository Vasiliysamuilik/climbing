
import UIKit

class PageCollectionView: UICollectionView {
    private var beforeDraggingCellIndex = 0
        
    var isWeekly: Bool = false
    
    // The width your page should have (plus a possible margin)
    var pageWidth: CGFloat = 0.0
        
    //MARK: - Behavior funcs
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        let proportionalOffset = contentOffset.x / pageWidth
        beforeDraggingCellIndex = Int(round(proportionalOffset))
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                   withVelocity velocity: CGPoint,
                                   targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        // Stop scrolling
        targetContentOffset.pointee = scrollView.contentOffset

        // Calculate conditions
        let itemsCount = numberOfItems(inSection: 0)
        let proportionalOffset = contentOffset.x / pageWidth
        let indexOfMajorCell = isWeekly ? Int(round(proportionalOffset))*7 : Int(round(proportionalOffset))
        let swipeVelocityThreshold: CGFloat = 0.5
        let hasEnoughVelocityToSlideNextCell = beforeDraggingCellIndex + 1 < itemsCount && velocity.x > swipeVelocityThreshold
        let hasEnoughVelocityToSlidePreviousCell = beforeDraggingCellIndex - 1 >= 0 && velocity.x < -swipeVelocityThreshold
        let majorCellIsTheCellBeforeDragging = indexOfMajorCell == beforeDraggingCellIndex
        let didUseSwipeToSkipCell = majorCellIsTheCellBeforeDragging
            && (hasEnoughVelocityToSlideNextCell || hasEnoughVelocityToSlidePreviousCell)

        if didUseSwipeToSkipCell && !isWeekly {
            // Animate so that swipe is just continued
            let snapToIndex = beforeDraggingCellIndex + (hasEnoughVelocityToSlideNextCell ? 1 : -1)
            let toValue = pageWidth * CGFloat(snapToIndex)
            UIView.animate(
                withDuration: 0.3,
                delay: 0,
                usingSpringWithDamping: 1,
                initialSpringVelocity: velocity.x,
                options: .allowUserInteraction,
                animations: {
                    scrollView.contentOffset = CGPoint(x: toValue, y: 0)
                    scrollView.layoutIfNeeded()
                }, completion: nil)
        } else {
            // Pop back (against velocity)
            print(indexOfMajorCell)
            let indexPath = IndexPath(row: indexOfMajorCell, section: 0)
            scrollToItem(at: indexPath, at: isWeekly ? .left : .centeredHorizontally, animated: true)
        }
    }
}
