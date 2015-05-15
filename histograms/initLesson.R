# Code placed in this file fill be executed every time the
# lesson is started. Any variables created here will show up in
# the user's working directory and thus be accessible to them
# throughout the lesson.

bph <- function(h=c(1,4,3,0.5),w=c(20,20,30,30),gray=2,
                Main="Histogram of Exam Scores",
                Xlab="Score Points",...)
{
  Col <- rep("white",length(h))
  Col[gray] <- "gray"
  barplot(h,w,space=0,col=Col,main=Main,xlab=Xlab,...)
  axis(1)
}