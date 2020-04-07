package view.interfaces
{
    import view.domino.surfaceComponents.components.DominoParagraph;

    /**
     * Interface related to PrimeFaces components.
     * If some component implementing it, we are exposing internal Div
     */
    public interface IDominoParagraph
    {
        function get dominoParagraph():DominoParagraph;
    }
}